//
//  UIImage+Ex.swift
//  GuestBook
//
//  Created by Антон Смирнов on 8.05.21.
//

import UIKit

extension UIImage {
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
