//
//  MyTableViewCell.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    //MARK: - Outlets


    @IBOutlet weak var nameLabel: MyLabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: MyLabel!
    @IBOutlet weak var messageLabel: MyLabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var createAtLable: UILabel!


    //MARK: - CellFunctions

    func setCell(model: Comment) {
        guard let avatarImage = model.user?.avatar else { return }
        guard let url = URL(string: avatarImage ) else { return }
        UIImage.loadFrom(url: url) { image in
            if image != nil {
            self.avatarImage.image = image
            } else {
                self.avatarImage.image = UIImage(named: "Photography")
            }
        }
        self.nameLabel.text = model.user?.name
        self.titleLabel.text = model.title
        self.messageLabel.text = model.message
        self.countLabel.text = model.answersCount.description
        self.createAtLable.text = model.createdAt.toDate().toString

    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}



