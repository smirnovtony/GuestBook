//
//  Links.swift
//  GuestBook
//
//  Created by Антон Смирнов on 6.05.21.
//

import Foundation
import ObjectMapper

class Links: Mappable {
    var first: String?
    var next: String?
    var prev: String?
//    var last: String?
    required init?(map: Map) {
    }

    init() {
    }
    func mapping(map: Map) {
        first <- map["first"]
        next <- map["next"]
        prev <- map["prev"]
//        last <- map["last"]
    }
}
//struct Links: Decodable {
//    let first: String?
//    let next: String?
//    let prev: String?
//    let last: String?
//}



