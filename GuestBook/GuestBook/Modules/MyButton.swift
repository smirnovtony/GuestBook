//
//  MyButton.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import UIKit

struct ButtonConfig {
    func configure(_ button: UIButton) {
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 5
        button.layer.shadowRadius = 20
    }
}

class MyButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ButtonConfig().configure(self)
    }
}
