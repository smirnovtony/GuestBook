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

    private let totalEnteries = NetworkManager.shared.meta?.total
    private var currentPage = 1

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerTableView.dataSource = self
        self.answerTableView.delegate = self
        self.answerTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.loading()
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
        if comments[indexPath.row].answersCount == 0 {
            let alertController = UIAlertController(title: "No any answers!",
                                                    message: "",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive)
            self.present(alertController, animated: true)
            alertController.addAction(okAction)
        } else {
        self.selectedMessageId = comments[indexPath.row].answers
        self.performSegue(withIdentifier: "ShowAnswers", sender: selectedMessageId)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard segue.identifier == "ShowAnswers",
              let model = sender as? [Answer],
              let vc =   segue.destination as? AnswersVC else { return }
        vc.answers = model
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let total = totalEnteries else { return }
        if  indexPath.row == comments.count - 1, comments.count < total, currentPage == NetworkManager.shared.meta?.currentPage {
            currentPage += 1
            refreshData(withPage: String(currentPage))
        }
    }

    @objc func loadTable() {
        self.answerTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Actions

    @IBAction func logOutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "tokenData")
        self.performSegue(withIdentifier: "LogOutButton", sender: self)
    }
}
