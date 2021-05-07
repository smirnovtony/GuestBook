//
//  User.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var user: String = ""
    var name: String = ""
    var avatar: String = ""
    var id: Int = 0
    var isAdmin: Int?
    var email: String = ""
    var createdAt: String?
    var updatedAt: String?
    var accessToken: String?
    var expiresAt: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        user <- map["user"]
        name <- map["name"]
        avatar <- map["avatar"]
        id <- map["id"]
        isAdmin <- map["is_admin"]
        email <- map["email"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        accessToken <- map["access_token"]
        expiresAt <- map["expires_at"]
    }
}
