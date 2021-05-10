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


