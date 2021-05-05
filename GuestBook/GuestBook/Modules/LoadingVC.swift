//
//  LoadingVC.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import UIKit

class LoadingVC: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var indicator: UIActivityIndicatorView!

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.indicator.startAnimating()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.indicator.stopAnimating()
        }
    }
}
