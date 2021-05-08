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
            self.indicatorLoading.stopAnimating()
            NetworkManager.shared.getComments()
            NetworkManager.shared.getMeta()
            NetworkManager.shared.getlinks()
            self.performSegue(withIdentifier: "Loading", sender: self)
            
        }
    }
}
