//
//  Loading.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import UIKit

class Loading: UIViewController {

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
//            if IYSharedData.sh.collectionInvites.count != 0 {
//                let tabBarController = IYTabBarViewController()
//                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
//            } else {
//                let alertController = UIAlertController(title: "Error",
//                                                        message: "Network connection error",
//                                                        preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in
//                    self.navigationController?.pushViewController(IYInitViewController(), animated: true)
//                }
//                self.present(alertController, animated: true)
//                alertController.addAction(okAction)
//            }
        }
    }
}
