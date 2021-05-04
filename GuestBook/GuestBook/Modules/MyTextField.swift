//
//  MyTextField.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import UIKit

struct TextFieldConfig {
    func configure(_ textField: UITextField) {
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.shadowRadius = 20
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor
    }
}

class MyTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        TextFieldConfig().configure(self)
    }
}

