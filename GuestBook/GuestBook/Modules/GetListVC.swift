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

    var comments: [Comment] = NetworkManager.shared.comment

    let cellReuseIdentifier = "MyCell"

    private lazy var filteredAnswers: [Comment] = self.comments {
        didSet {
            self.answerTableView.reloadData()
        }
    }

    var selectedMessageId: [Answer]?

    var limit = NetworkManager.shared.meta?.perPage
    let totalEnteries = NetworkManager.shared.meta?.total
    var totalPage = NetworkManager.shared.meta?.lastPage
    var currentPage = 1

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
        return self.filteredAnswers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                                 for: indexPath) as? MyTableViewCell ?? MyTableViewCell()

            cell.setCell(model: self.filteredAnswers[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredAnswers[indexPath.row].answersCount == 0 {
            let alertController = UIAlertController(title: "No any answers!",
                                                    message: "",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive)
            self.present(alertController, animated: true)
            alertController.addAction(okAction)
        } else {
        self.selectedMessageId = filteredAnswers[indexPath.row].answers
        self.performSegue(withIdentifier: "ShowAnswers", sender: selectedMessageId)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

        guard segue.identifier == "ShowAnswers",
              let model = sender as? [Answer],
              let vc =   segue.destination as? AnswersVC else { return }
        vc.selectedCellData = model
    }
    private func loading() {
        if self.filteredAnswers.count == 0 {
            self.navigationController?.popViewController(animated: false)
        }
    }

    private func refreshData(withPage: String) {
        self.filteredAnswers.removeAll()
        NetworkManager.shared.getCommentsNext(with: withPage)
        self.filteredAnswers.append(contentsOf: NetworkManager.shared.comment)
        print(NetworkManager.shared.comment.count)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard totalEnteries != nil else { return }
        guard let totalPage = totalPage else { return }
        guard let totalPage1 = totalPage else { return }
        if currentPage < totalPage1 && indexPath.row == filteredAnswers.count - 1 {
            currentPage += 1
            refreshData(withPage: String(currentPage))

        }
    }
//    @objc func loadTable() {
//        self.answerTableView.reloadData()
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Actions

    @IBAction func getlist(_ sender: Any) {
        NetworkManager.shared.getPosts()

    }
    @IBAction func logOutButtonTapped(_ sender: Any) {
        // сброс логина и пароля

    }
}

