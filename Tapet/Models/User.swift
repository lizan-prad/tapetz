/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

class User : Mappable {
	var id : String?
	var updated_at : String?
	var username : String?
	var name : String?
	var first_name : String?
	var last_name : String?
	var twitter_username : String?
	var portfolio_url : String?
	var bio : String?
	var location : String?
	var links : Links?
	var profile_image : Profile_image?
	var instagram_username : String?
	var total_collections : Int?
	var total_likes : Int?
	var total_photos : Int?
	var accepted_tos : Bool?
    
    init() {
        
    }

	required init?(map: Map) {

	}

    func mapping(map: Map) {

		id <- map["id"]
		updated_at <- map["updated_at"]
		username <- map["username"]
		name <- map["name"]
		first_name <- map["first_name"]
		last_name <- map["last_name"]
		twitter_username <- map["twitter_username"]
		portfolio_url <- map["portfolio_url"]
		bio <- map["bio"]
		location <- map["location"]
		links <- map["links"]
		profile_image <- map["profile_image"]
		instagram_username <- map["instagram_username"]
		total_collections <- map["total_collections"]
		total_likes <- map["total_likes"]
		total_photos <- map["total_photos"]
		accepted_tos <- map["accepted_tos"]
	}
    
//    func toRealm() -> ImageRealmUser {
//        let model = ImageRealmUser()
//        model.id = self.id ?? ""
//        model.username = self.username ?? ""
//        model.name = self.name ?? ""
//        model.first_name = self.first_name ?? ""
//        model.last_name = self.last_name ?? ""
//        model.twitter_username = self.twitter_username ?? ""
//        model.portfolio_url = self.portfolio_url ?? ""
//        model.bio = self.bio ?? ""
//        model.location = self.location ?? ""
//        model.profile_image = self.profile_image?.toRealm()
//        model.instagram_username = self.instagram_username ?? ""
//        model.total_likes = self.total_likes ?? 0
//        model.total_photos = self.total_photos ?? 0
//        model.total_collections = self.total_collections ?? 0
//        return model
//    }

}

//class ImageRealmUser: Object {
//    
//    @objc dynamic var id : String = ""
//    @objc dynamic var username : String = ""
//    @objc dynamic var name : String = ""
//    @objc dynamic var first_name : String = ""
//    @objc dynamic var last_name : String = ""
//    @objc dynamic var twitter_username : String = ""
//    @objc dynamic var portfolio_url : String = ""
//    @objc dynamic var bio : String = ""
//    @objc dynamic var location : String = ""
//    var profile_image : UserProfileImageRealm?
//    @objc dynamic var instagram_username : String = ""
//    @objc dynamic var total_collections : Int = 0
//    @objc dynamic var total_likes : Int = 0
//    @objc dynamic var total_photos : Int = 0
//    
//    override open class func primaryKey() -> String? {
//        return "id"
//    }
//    
//    func toNormal() -> User {
//        let model = User()
//        model.id = self.id
//        model.username = self.username
//        model.name = self.name
//        model.first_name = self.first_name
//        model.last_name = self.last_name
//        model.twitter_username = self.twitter_username
//        model.portfolio_url = self.portfolio_url
//        model.bio = self.bio
//        model.location = self.location
//        model.profile_image = self.profile_image?.toNormal()
//        model.instagram_username = self.instagram_username
//        model.total_likes = self.total_likes
//        model.total_photos = self.total_photos
//        model.total_collections = self.total_collections 
//        return model
//    }
//
//}
