//
//  Comment.swift
//  GuestBook
//
//  Created by Антон Смирнов on 7.05.21.
//

import Foundation
import ObjectMapper

class Comment: Mappable {
    var answers: [Answer]?
    var answersCount: Int = 0
    var createdAt: String = ""
    var id: Int?
    var message: String = ""
    var title: String = ""
    var updatedAt: String = ""
    var user: User?

    required init?(map: Map) {
    }

    init() {
    }

    func mapping(map: Map) {
        answers <- map["answers"]
        answersCount <- map["answers_count"]
        createdAt <- map["created_at"]
        id <- map["id"]
        message <- map["message"]
        title <- map["title"]
        updatedAt <- map["updated_at"]
        user <- map["user"]
    }
}
