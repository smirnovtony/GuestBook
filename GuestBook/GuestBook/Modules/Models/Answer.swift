//
//  Answer.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import Foundation

struct Answer: Decodable {
    let id: Int
    let post_id: Int
    let user_id: Int
    let message: String
    let created_at: String
    let updated_at: String
}
