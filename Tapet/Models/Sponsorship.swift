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

struct Sponsorship : Mappable {
	var impressions_id : String?
	var tagline : String?
	var sponsor : Sponsor?

	init?(map: Map) {

	}
    
    init() {
        
    }

	mutating func mapping(map: Map) {

		impressions_id <- map["impressions_id"]
		tagline <- map["tagline"]
		sponsor <- map["sponsor"]
	}
    
//    func toRealm() -> SponsorShipRealm{
//        let model = SponsorShipRealm()
//        model.impressions_id = self.impressions_id ?? ""
//        model.sponsor = self.sponsor?.toRealm()
//        return model
//    }

}

//class SponsorShipRealm: Object {
//    var impressions_id : String?
//    var sponsor : SponserRealm?
//
//    override open class func primaryKey() -> String? {
//        return "impressions_id"
//    }
//
//    func toNormal() -> Sponsorship{
//        var model = Sponsorship()
//        model.impressions_id = self.impressions_id ?? ""
//        model.sponsor = self.sponsor?.toNormal()
//        return model
//    }
//}
