//
//  User.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import Foundation

struct User: Codable {
    var name: String
    var avatar: String
    var id: Int
    var isAdmin: Int?
    var email: String
    var accessToken: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        avatar = try container.decode(String.self, forKey: .avatar)
        email = try container.decode(String.self, forKey: .email)
        id = try container.decode(Int.self, forKey: .id)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        isAdmin = try container.decodeIfPresent(Int.self, forKey: .isAdmin)
    }
    enum CodingKeys: String, CodingKey {
        case name
        case avatar = "avatar"
        case accessToken = "access_token"
        case id
        case isAdmin = "is_admin"
        case email
        case password
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(id, forKey: .id)
        try container.encode(isAdmin, forKey: .isAdmin)
        try container.encode(email, forKey: .email)
    }
}
