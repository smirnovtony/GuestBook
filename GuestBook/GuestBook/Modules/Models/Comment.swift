//
//  Comment.swift
//  GuestBook
//
//  Created by Антон Смирнов on 7.05.21.
//

import Foundation
import ObjectMapper

class Comment: Mappable {
    var title: String = ""
    var message: String = ""
    var answers: [Answer]?
    var user: User?
    var id: Int?
    var createdAt: String = ""
    var answersCount: Int = 0
    required init?(map: Map) {
    }

    init() {
    }

    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        message <- map["message"]
        answers <- map["answers"]
        user <- map["user"]
        createdAt <- map["created_at"]
        answersCount <- map["answers_count"]
    }
}
