//
//  Answer.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import Foundation
import ObjectMapper

class Answer: Mappable {
    var createdAt: String = ""
    var id: Int?
    var message: String = ""
    var postId: String = ""
    var updatedAt: String = ""
    var userId: Int = 0
    required init?(map: Map) {
    }

    init() {
    }

    func mapping(map: Map) {
        createdAt <- map["created_at"]
        id <- map["id"]
        message <- map["message"]
        postId <- map["post_id"]
        updatedAt <- map["updated_at"]
        userId <- map["user_id"]

    }
}



