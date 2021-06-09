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
    @IBOutlet weak var addAnswerButton: UIBarButtonItem!
    
    //MARK: - Variables
    
    private let cellReuseIdentifierAns = "MyAnsCell"
    
    var answers: [Answer] = []
    let userAdmin = UserDefaults.standard.value(forKey: "isAdmin")
    
    func userIsAdmin() {
        guard let userStatement = userAdmin else { return }
        if let userRightsStatus = userStatement as? Int {
            if userRightsStatus == 0 {
                if let button = self.navigationItem.rightBarButtonItem {
                    button.isEnabled = false
                    button.tintColor = UIColor.clear
                }
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !NetworkManager.shared.user.isEmpty {
        }
        self.answerTabelView.delegate = self
        self.answerTabelView.dataSource = self
        self.answerTabelView.register(UINib(nibName: "AnswersTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifierAns)
        self.answerTabelView.backgroundColor = .white
        self.userIsAdmin()
        
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(answers.count)
        return answers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifierAns,
                                                 for: indexPath) as? AnswersTableViewCell ?? AnswersTableViewCell()
        cell.setAnswerCell(model: self.answers[indexPath.row])
        return cell
    }
    

}
