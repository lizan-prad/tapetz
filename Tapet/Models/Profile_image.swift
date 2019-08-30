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

struct Profile_image : Mappable {
	var small : String?
	var medium : String?
	var large : String?

	init?(map: Map) {

	}
    
    init() {
        
    }

	mutating func mapping(map: Map) {

		small <- map["small"]
		medium <- map["medium"]
		large <- map["large"]
	}
    
    func toRealm() -> UserProfileImageRealm {
        let model = UserProfileImageRealm()
        model.small = self.small ?? ""
        model.medium = self.medium ?? ""
        model.large = self.large ?? ""
        return model
    }
}

class UserProfileImageRealm: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var small : String = ""
    @objc dynamic var medium : String = ""
    @objc dynamic var large : String = ""
    
    func toNormal() -> Profile_image {
        var model = Profile_image()
        model.small = self.small
        model.medium = self.medium
        model.large = self.large
        return model
    }
}
