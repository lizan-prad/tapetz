//
//  Auth.swift
//  Tapet
//
//  Created by Lizan P on 8/28/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON
import GoogleMobileAds


struct Constants {
    static var baseUrl = "https://api.unsplash.com/"
    static var clientId = "22502590ac9a324c3c5cc2cebe61c13e6b7e6a18365377c38b2684f78ed8c358"
    static var baseColor = UIColor.init(hex: "#FF5656")//UIColor.init(hex: "#A53A79")
}

class Auth {
    
    static let shared = Auth()
    
    func request<T: Mappable>(_ value: T.Type ,urlExt: String, method: HTTPMethod, param: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (T) -> (), failure: @escaping (Error) ->()){
        
        let header = headers == nil ? ["Content-type" : "application/json"] : headers
        
        Alamofire.request(Constants.baseUrl + urlExt, method: method, parameters: param, encoding: encoding, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                switch response.response?.statusCode ?? 0 {
                case 200:
                    if let dataDict = data as? [String:Any], let value = Mapper<T>().map(JSON: dataDict) {
                        completion(value)
                    }
                    break
                case 400:
//                    if let dataDict = data as? [String:Any], let value = Mapper<ApiResponseModel>().map(JSON: dataDict) {
//                        failure(NSError.init(domain: "FAILURE", code: 400, userInfo: [NSLocalizedDescriptionKey: value.message ?? ""]))
//                    }
                    break
                default:
                    break
                }
                
                break
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func requestArray<T: Mappable>(_ value: T.Type ,urlExt: String, method: HTTPMethod, param: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (T) -> (), failure: @escaping (Error) ->()){
        
        let header = headers == nil ? ["Content-type" : "application/json"] : headers
        
        Alamofire.request(Constants.baseUrl + urlExt, method: method, parameters: param, encoding: encoding, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                switch response.response?.statusCode ?? 0 {
                case 200:
                    if let dataDict = data as? [[String:Any]], let value = Mapper<T>().map(JSON: ["data" : dataDict]) {
                        completion(value)
                    }
                    break
                case 400:
//                    if let dataDict = data as? [String:Any], let value = Mapper<ApiResponseModel>().map(JSON: dataDict) {
//                        failure(NSError.init(domain: "FAILURE", code: 400, userInfo: [NSLocalizedDescriptionKey: value.message ?? ""]))
//                    }
                    break
                default:
                    break
                }
                
                break
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func requestMultiPart<T: Mappable>(_ value: T.Type ,urlExt: String, image: Data?, param: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (T) -> (), failure: @escaping (Error) ->()){
        
        let header = ["Content-type" : "multipart/form-data", "Authorization": (UserDefaults.standard.value(forKey: "T") as! String)]
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //            for (key, value) in param ?? [:] {
            //                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            //            }
            
            if let data = image{
                multipartFormData.append(data, withName: "file", fileName: "image_\(Date()).jpg", mimeType: "image/jpg")
            }
            
        }, usingThreshold: UInt64.init(), to: Constants.baseUrl + urlExt, method: .post, headers: header) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (data) in
                    if let dict = data.value as? [String:Any], let val = Mapper<T>().map(JSON: dict) {
                        completion(val)
                    }
                })
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                failure(error)
            }
        }
    }
    
    
}

