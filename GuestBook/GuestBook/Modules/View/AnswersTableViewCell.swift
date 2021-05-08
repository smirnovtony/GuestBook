//
//  AnswersTableViewCell.swift
//  GuestBook
//
//  Created by Антон Смирнов on 8.05.21.
//

import UIKit

class AnswersTableViewCell: UITableViewCell {


    @IBOutlet weak var userIdLabel: MyLabel!
    @IBOutlet weak var messageLabel: MyLabel!
    @IBOutlet weak var createAtLabel: UILabel!

    func setAnswerCell(model: Answer) {
        self.userIdLabel.text = String(model.userId)
        self.messageLabel.text = model.message
        self.createAtLabel.text = model.createdAt.toDate().toString
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
