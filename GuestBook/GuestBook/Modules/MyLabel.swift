//
//  MyLabel.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import UIKit

struct LabelConfig {
    func configure(_ label: UILabel) {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.layer.shadowRadius = 20
        label.layer.shadowOpacity = 0.5
        label.layer.shadowColor = UIColor.gray.cgColor
    }
}

class MyLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        LabelConfig().configure(self)
    }
}
