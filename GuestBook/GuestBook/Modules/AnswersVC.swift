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

    let cellReuseIdentifierAns = "cellAns"

    var recordsArray:[Int] = Array()
    var limit = 10
    let totalEnteries = 39 //NetworkManager.shared.linksDict["last"]

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerTabelView.delegate = self
        self.answerTabelView.dataSource = self
        self.answerTabelView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifierAns)

        var index = 0
        while index < limit {
            recordsArray.append(index)
            index = index + 1
        }
    }

//MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
//            NetworkManager.shared.dataDict.count // заменить на количество ячеек в массиве
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifierAns,
                                                 for: indexPath) as? MyTableViewCell ?? MyTableViewCell()

//        cell.setCell(model: self.filteredAnswers[indexPath.row]) раскоментить!!!!!!!
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recordsArray.count - 1 {
            // we are at last cell load more content
            if recordsArray.count < totalEnteries {
                // we need to bring more records as there are some pending records available
                var index = recordsArray.count
                limit = index + 20
                while index < limit {
                    recordsArray.append(index)
                    index = index + 1
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 2.0)
            }
        }
    }
    @objc func loadTable() {
        self.answerTabelView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
