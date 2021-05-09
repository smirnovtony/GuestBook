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
    @IBOutlet weak var emailField: MyTextField!{
        didSet {
            emailField.text = "test@gmail.com"
        }
    }
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: MyTextField! {
        didSet {
            passwordField.text = "12345678"
        }
    }
    @IBOutlet weak var registrationButton: MyButton!

    //MARK: - Variables

    private var email: String {
        self.emailField.text ?? ""
    }
    private var password: String {
        self.passwordField.text ?? ""
    }
    private var successfulCondition: Bool = false

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

    private func logInConditions() -> Bool {
        if self.email.isEmpty, self.password.isEmpty {
            alertLogIn(title: "Error", message: "Fill in all the fields")
        } else {
            successfulCondition = true
            alertLogIn(title: "Successful login", message: "")
        }
        return successfulCondition
    }

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
        if let email = self.emailField.text,
           let password = self.passwordField.text {
            NetworkManager.shared.login(withEmail: email, password: password)
            if !NetworkManager.shared.token.isEmpty {
                alertLogIn(title: "Error!", message: "Authorization Failed")
            } else {
                self.performSegue(withIdentifier: "LoadingVC", sender: Any?.self)
            }

        }
    }
}


