//
//  User.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var avatar: String = ""
    var createdAt: String?
    var email: String = ""
    var id: Int = 0
    var isAdmin: Int?
    var name: String = ""
    var updatedAt: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        avatar <- map["avatar"]
        createdAt <- map["created_at"]
        email <- map["email"]
        id <- map["id"]
        isAdmin <- map["is_admin"]
        name <- map["name"]
        updatedAt <- map["updated_at"]
    }
}
