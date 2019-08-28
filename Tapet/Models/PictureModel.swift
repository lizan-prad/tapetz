//
//  PictureModel.swift
//  Tapet
//
//  Created by Hem Raj Bhatt on 8/27/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import Foundation
import ObjectMapper

class BasePictureModel<T: Mappable>: Mappable {
    
    var data: [T]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
            data <- map["data"]
    }
}

class PictureModel: Mappable {
    var id : String?
    var created_at : String?
    var updated_at : String?
    var width : Int?
    var height : Int?
    var color : String?
    var description : String?
    var alt_description : String?
    var urls : Urls?
    var links : Links?
    var categories : [String]?
    var likes : Int?
    var liked_by_user : Bool?
    var current_user_collections : [String]?
    var user : User?
    var sponsorship : Sponsorship?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        width <- map["width"]
        height <- map["height"]
        color <- map["color"]
        description <- map["description"]
        alt_description <- map["alt_description"]
        urls <- map["urls"]
        links <- map["links"]
        categories <- map["categories"]
        likes <- map["likes"]
        liked_by_user <- map["liked_by_user"]
        current_user_collections <- map["current_user_collections"]
        user <- map["user"]
        sponsorship <- map["sponsorship"]
    }
    
}
