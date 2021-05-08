//
//  Meta.swift
//  GuestBook
//
//  Created by Антон Смирнов on 6.05.21.
//

import Foundation
import ObjectMapper

class Meta: Mappable {
    var currentPage: Int?
    var from: Int??
    var lastPage: Int??
    var path: String?
    var perPage: Int?
    var to: Int?
    var total: Int?
    required init?(map: Map) {
    }

    init() {
    }
    func mapping(map: Map) {
        currentPage <- map["current_page"]
        from <- map["from"]
        lastPage <- map["last_page"]
        path <- map["path"]
        perPage <- map["per_page"]
        to <- map["to"]
        total <- map["total"]
    }
}

//struct Meta: Decodable {
//    let currentPage: Int?
//    let from: Int?
//    let lastPage: Int?
//    let path: String?
//    let perPage: Int?
//    let to: Int?
//    let total: Int?
//}
//enum CodingKeys: String, CodingKey {
//    case currentPage = "current_page"
//    case from
//    case lastPage = "last_page"
//    case path
//    case perPage = "per_page"
//    case to
//    case total
//}


