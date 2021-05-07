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

    @IBAction func getlist(_ sender: Any) {
        NetworkManager.shared.getPosts()
        
    }

    //MARK: - Variables

    var comments: [Comment] = NetworkManager.shared.comment

    let cellReuseIdentifier = "cell"

    private lazy var filteredAnswers: [Comment] = self.comments {
        didSet {
            self.answerTableView.reloadData()
        }
    }
    // НЕ УДАЛЯТЬ!!
//    var recordsArray: [Int] = Array()
//    var limit = 10
//    let totalEnteries = 39 //NetworkManager.shared.linksDict["last"]

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.answerTableView.dataSource = self
        self.answerTableView.delegate = self
        self.answerTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        // НЕ УДАЛЯТЬ!!
//        var index = 0
//        while index < limit {
//            recordsArray.append(index)
//            index = index + 1
//        }
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
        self.performSegue(withIdentifier: "ShowAnswers", sender: self)
//        for i in NetworkManager.shared.comment {
//            print()
//            print("avatar  \(i.user?.avatar)")
//            print("name  \(i.user?.name)")
//            print("id  \(i.user?.id)")
//            print("email  \(i.user?.email)")
//            print("message   \(i.message)")
//            print("title   \(i.title)")
//            if i.answers != nil {
//                for z in i.answers! {
//                    print("answers   \(z.message)")
//                }
//            }
//        }
    }


    // НЕ УДАЛЯТЬ!!
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
//        self.answerTableView.reloadData()
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

}

