//
//  Data+Ex.swift
//  GuestBook
//
//  Created by Антон Смирнов on 8.05.21.
//

import Foundation

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        return formatter.string(from: self)
    }
}
extension String {
  func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
}
