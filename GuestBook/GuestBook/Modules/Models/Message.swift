//
//  Message.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import Foundation

struct Message: Decodable {
    let id: Int
    let user_id: Int
    let title: String
    let message: String
    let created_at: String
    let updated_at: String
}
