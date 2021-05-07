//
//  MyTableViewCell.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: MyLabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: MyLabel!
    @IBOutlet weak var messageLabel: MyLabel!

    func setCell(model: Comment) {
        // картинка
//        guard let url = URL(string: model.user!.avatar ) else { return } // сделать что-то с FORCE UNWRAP
//        UIImage.loadFrom(url: url) { image in
//            self.avatarImage = image
//        }
        self.nameLabel.text = model.user?.name
        self.titleLabel.text = model.title
        self.messageLabel.text = model.message
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
