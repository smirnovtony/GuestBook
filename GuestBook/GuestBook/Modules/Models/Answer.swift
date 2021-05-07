//
//  Answer.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import Foundation
import ObjectMapper

class Answer: Mappable {
    var message: String = ""
    required init?(map: Map) {
    }

    init() {
    }

    func mapping(map: Map) {
        message <- map["message"]
    }
}


//struct Answer: Decodable {
//    let id: Int
//    let postId: Int
//    let userId: Int
//    let message: String
//    let createdAt: String
//    let updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case postId = "post_id"
//        case userId = "user_id"
//        case message
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}



