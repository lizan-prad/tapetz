/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct User : Mappable {
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

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

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

}