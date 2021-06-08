//
//  Configuration.swift
//  GuestBook
//
//  Created by iOS NavekSoft on 8.06.21.
//

import Foundation

import Foundation

protocol Configuration {
    var host: String { get }
    var version: String { get }
    var webUrl: String { get }
    var space: String { get }
}
