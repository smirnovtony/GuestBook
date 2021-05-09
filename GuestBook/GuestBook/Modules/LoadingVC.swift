//
//  LoadingVC.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import UIKit

class LoadingVC: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.indicatorLoading.startAnimating()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                NetworkManager.shared.getComments()
                NetworkManager.shared.getMeta()
                NetworkManager.shared.getlinks()
                self.indicatorLoading.stopAnimating()
                self.performSegue(withIdentifier: "GetListVC", sender: self)

            }
        }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        DispatchQueue.main.async {
//            self.indicatorLoading.startAnimating()
//            NetworkManager.shared.getComments()
//            NetworkManager.shared.getMeta()
//            NetworkManager.shared.getlinks()
//            self.loading()
//
//        }
//    }
//        func loading() {
//            if NetworkManager.shared.comment.isEmpty {
//                let alertController = UIAlertController(title: "Error",
//                                                        message: "Сheck your network connection. Try again",
//                                                        preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//                    self.performSegue(withIdentifier: "GetListVC", sender: self)
//                }
//                alertController.addAction(okAction)
//                self.present(alertController, animated: true)
//
//            } else {
//                self.performSegue(withIdentifier: "GetListVC", sender: self)
//
//            }
//        }

}
