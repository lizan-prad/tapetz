//
//  PictureModel.swift
//  Tapet
//
//  Created by Hem Raj Bhatt on 8/27/19.
//  Copyright © 2019 Lizan Pradhanang. All rights reserved.
//

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class BasePictureModel<T: Mappable>: Mappable {
    
    var data: [T]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
            data <- map["data"]
    }
}

class SearchBaseModel: Mappable {
    
    var result: [PictureModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        result <- map["results"]
    }
}

class PictureModel: Mappable {
    var id : String?
    var created_at : String?
    var updated_at : String?
    var width : Int?
    var height : Int?
    var color : String?
    var descriptions : String?
    var alt_description : String?
    var urls : Urls?
    var links : Links?
    var categories : [String]?
    var likes : Int?
    var liked_by_user : Bool?
    var current_user_collections : [String]?
    var user : User?
    var imageData: Data?
    var sponsorship : Sponsorship?
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        width <- map["width"]
        height <- map["height"]
        color <- map["color"]
        descriptions <- map["description"]
        alt_description <- map["alt_description"]
        urls <- map["urls"]
        urls?.id = self.id
        links <- map["links"]
        categories <- map["categories"]
        likes <- map["likes"]
        liked_by_user <- map["liked_by_user"]
        current_user_collections <- map["current_user_collections"]
        user <- map["user"]
        user?.profile_image?.id = self.id
        sponsorship <- map["sponsorship"]
    }
    
    func toRealm() -> PictureRealmModel {
        let model = PictureRealmModel()
        model.id = self.id ?? ""
        model.image = self.imageData
        model.likes = self.likes ?? 0
        model.height = self.height ?? 0
        model.width = self.width ?? 0
        model.color = self.color ?? ""
        model.descriptions = self.descriptions ?? ""
        model.alt_description = self.alt_description ?? ""
//        model.urls = self.urls?.toRealm()
//        model.user = self.user?.toRealm()
        model.image = self.imageData
//        model.sponsorship = self.sponsorship?.toRealm()
        return model
    }
    
}

class PictureRealmModel: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var likes: Int = 0
    @objc dynamic var image: Data?
    @objc dynamic var width : Int = 0
    @objc dynamic var height : Int = 0
    @objc dynamic var color : String = ""
    @objc dynamic var descriptions : String = ""
    @objc dynamic var alt_description : String = ""
//    var urls : UrlsRealm?
//    var user : ImageRealmUser?
//    var sponsorship : SponsorShipRealm?
    
    override open class func primaryKey() -> String? {
        return "id"
    }
    
    func toNormal() -> PictureModel {
        let model = PictureModel()
        model.id = self.id
        model.imageData = self.image
        model.likes = self.likes
        model.height = self.height
        model.width = self.width
        model.color = self.color
        model.descriptions = self.descriptions
        model.alt_description = self.alt_description
//        model.urls = self.urls?.toNormal()
//        model.user = self.user?.toNormal()
//        model.sponsorship = self.sponsorship?.toNormal()
        return model
    }
    
}
