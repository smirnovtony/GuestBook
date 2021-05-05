//
//  GetListVC.swift
//  GuestBook
//
//  Created by Антон Смирнов on 5.05.21.
//

import UIKit

class GetListVC: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.cornerRadius = 50
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var titleLabel: MyLabel!
    @IBOutlet weak var messageLabel: MyLabel!
    @IBOutlet weak var answerTableView: UITableView!

    //MARK: - Variables

    let cellReuseIdentifier = "cell"
    private var answers: [Answer] = []
    private lazy var filteredAnswers: [Answer] = self.answers {
        didSet {
            self.answerTableView.reloadData()
        }
    }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        answerTableView.dataSource = self
        answerTableView.delegate = self
        answerTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.navigationController?.isNavigationBarHidden = true
    }
}

//MARK: - Extensions

extension GetListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50 // заменить на количество ячеек в массиве
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        if cell == nil {
            cell = MyTableViewCell()
        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MyTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
//                                                 for: indexPath) as? MyTableViewCell ?? MyTableViewCell()
//        cell.setCell(model: self.имя_массива[indexPath.row])
        return cell!
    }
}
