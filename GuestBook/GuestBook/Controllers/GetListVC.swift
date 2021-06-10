//
//  GetListVC.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import UIKit

class GetListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var answerTableView: UITableView!
    
    //MARK: - Variables
    
    private let cellReuseIdentifier = "MyCell"
    
    private lazy var comments: [Comment] = NetworkManager.shared.comment {
        didSet {
            self.answerTableView.reloadData()
        }
    }
    
    var selectedMessageId: [Answer]?
    var selectedComment: Int?
    
    private let totalEnteries = NetworkManager.shared.meta?.total
    private var currentPage = 1
    let userAdmin = UserDefaults.standard.value(forKey: "isAdmin")
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerTableView.dataSource = self
        self.answerTableView.delegate = self
        self.answerTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.loading()
        self.answerTableView.backgroundColor = .white
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                                 for: indexPath) as? MyTableViewCell ?? MyTableViewCell()
        
        cell.setCell(model: self.comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if comments[indexPath.row].answersCount != 0 {
            self.selectedMessageId = comments[indexPath.row].answers
            self.selectedComment = comments[indexPath.row].id
            self.performSegue(withIdentifier: "ShowAnswers", sender: selectedMessageId)
        } else {
            guard let userStatement = userAdmin else { return }
            self.selectedComment = comments[indexPath.row].id
            if let userRightsStatus = userStatement as? Int {
                if userRightsStatus == 1 {
                    self.performSegue(withIdentifier: "adminAnswer", sender: selectedComment)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let total = totalEnteries else { return }
        if  indexPath.row == comments.count - 1, comments.count < total, currentPage == NetworkManager.shared.meta?.currentPage {
            currentPage += 1
            refreshData(withPage: String(currentPage))
        }
    }
    
    //MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ShowAnswers" {
            guard let model = sender as? [Answer] else { return }
            guard let vc = segue.destination as? AnswersVC else { return }
            vc.answers = model
        } else if segue.identifier == "adminAnswer" {
            guard let model2 = sender as? Int? else { return }
            guard let vc = segue.destination as? NewAnswer else { return }
            vc.postId = model2
        }
    }
    
    private func loading() {
        if self.comments.count == 0 {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    private func refreshData(withPage: String) {
        self.comments.removeAll()
        NetworkManager.shared.getCommentsNext(with: withPage)
        self.comments.append(contentsOf: NetworkManager.shared.comment)
        self.perform(#selector(loadTable), with: nil, afterDelay: 1.5)
    }
    
    @objc func loadTable() {
        self.answerTableView.reloadData()
    }
    
    //MARK: - Actions
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "tokenData")
        self.performSegue(withIdentifier: "LogOutButton", sender: self)
    }
}
