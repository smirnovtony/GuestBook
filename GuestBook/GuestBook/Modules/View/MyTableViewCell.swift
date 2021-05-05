//
//  MyTableViewCell.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabelCell: MyLabel!
    @IBOutlet weak var answerLabelCell: MyLabel!
    @IBOutlet weak var timeLabelCell: UILabel!


    func setCell(model: Answer) {
        self.idLabelCell.text = String(model.user_id)
        self.answerLabelCell.text = model.message
        self.timeLabelCell.text = model.created_at
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
