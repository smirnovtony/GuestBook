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

    let cellReuseIdentifierAns = "MyAnsCell"

    var selectedCellData: [Answer]?
    
//    var ans: [Answer]? = self.selectedCellData

    private lazy var filteredAnswers: [Answer]? = self.selectedCellData {
        didSet {
            self.answerTabelView.reloadData()
        }
    }

//    var recordsArray:[Int] = Array()
//    var limit = 10
//    let totalEnteries = 39 //NetworkManager.shared.linksDict["last"]

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerTabelView.delegate = self
        self.answerTabelView.dataSource = self
        self.answerTabelView.register(UINib(nibName: "AnswersTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifierAns)
//        self.notAnswers()

//        var index = 0
//        while index < limit {
//            recordsArray.append(index)
//            index = index + 1
//        }
    }

//MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredAnswers != nil {
            return filteredAnswers!.count // FORCE UNWRAP!!!!
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifierAns,
                                                 for: indexPath) as? AnswersTableViewCell ?? AnswersTableViewCell()
//        print(selectedCellData as Any)
//        if selectedCellData != nil {
//        for i in selectedCellData! {
//            print(i.id)
//        }
//        }
        if filteredAnswers != nil {
            cell.setAnswerCell(model: self.filteredAnswers![indexPath.row]) // FORCE UNWRAP!!!!
            return cell
        }
        return cell


//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == recordsArray.count - 1 {
//            // we are at last cell load more content
//            if recordsArray.count < totalEnteries {
//                // we need to bring more records as there are some pending records available
//                var index = recordsArray.count
//                limit = index + 20
//                while index < limit {
//                    recordsArray.append(index)
//                    index = index + 1
//                }
//                self.perform(#selector(loadTable), with: nil, afterDelay: 2.0)
//            }
//        }
//    }
//    @objc func loadTable() {
//        self.answerTabelView.reloadData()
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
}
    
}
