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
        NetworkManager.shared.getComments()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.indicatorLoading.stopAnimating()
            self.performSegue(withIdentifier: "GetListVC", sender: self)

        }
    }
}
