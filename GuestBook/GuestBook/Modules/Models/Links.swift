//
//  Links.swift
//  GuestBook
//
//  Created by Антон Смирнов on 6.05.21.
//

import Foundation
import ObjectMapper

class Links: Mappable {
    var first: Int = 1
    var next: Int?
    var prev: Int?
    var last: Int?
    required init?(map: Map) {
    }

    init() {
    }
    func mapping(map: Map) {
        first <- map["first"]
        next <- map["next"]
        prev <- map["prev"]
        last <- map["last"]
    }
}
//struct Links: Decodable {
//    let first: String?
//    let next: String?
//    let prev: String?
//    let last: String?
//}



