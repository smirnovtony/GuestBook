//
//  MyView.swift
//  GuestBook
//
//  Created by iOS NavekSoft on 9.06.21.
//

import UIKit

struct ViewConfig {
    func configure(_ label: UIView) {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
    }
}

class MyView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ViewConfig().configure(self)
    }
}
