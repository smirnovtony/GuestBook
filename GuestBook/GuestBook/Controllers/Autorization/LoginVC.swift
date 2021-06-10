//
//  LoginVC.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import UIKit

class LoginVC: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: MyTextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: MyTextField!
    @IBOutlet weak var registrationButton: MyButton!

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.userAlreadylogged()
    }

    //MARK: - Functions

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
    }
    private func userAlreadylogged() {
        if UserDefaults.standard.value(forKey: "tokenData") != nil {
            self.performSegue(withIdentifier: "LoadingVC", sender: self)
        } else {
            return
        }
    }
    //MARK: - LogInConditions

    private func alertLogIn(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }

    //MARK: - Actions

    @IBAction func loginButtonTapped(_ sender: Any) {
        if let email = self.emailField.text, let password = self.passwordField.text {
            if email.isEmpty || password.isEmpty {
                self.alertLogIn(title: "Error!", message: "Fill in all fields!")
            } else {
                NetworkManager.shared.login(withEmail: email, password: password)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    if NetworkManager.shared.token.isEmpty {
                        self.alertLogIn(title: "Error!", message: "Authorization Failed")
                    } else {
                        self.performSegue(withIdentifier: "LoadingVC", sender: Any?.self)
                    }
                }
            }
        }
    }
}
