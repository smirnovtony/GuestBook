//
//  AnswersVC.swift
//  GuestBook
//
//  Created by Антон Смирнов on 7.05.21.
//

import UIKit

class AnswersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var answerTabelView: UITableView!
    
    //MARK: - Variables
    
    private let cellReuseIdentifierAns = "MyAnsCell"
    
    var answers: [Answer]?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerTabelView.delegate = self
        self.answerTabelView.dataSource = self
        self.answerTabelView.register(UINib(nibName: "AnswersTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifierAns)
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifierAns,
                                                 for: indexPath) as? AnswersTableViewCell ?? AnswersTableViewCell()
        cell.setAnswerCell(model: self.answers![indexPath.row])
        return cell
    }
}
