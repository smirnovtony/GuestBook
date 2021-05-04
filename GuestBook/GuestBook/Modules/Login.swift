//
//  Login.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import UIKit

class Login: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!

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
    //MARK: - LogInConditions

    private func logInConditions() -> Bool {
        if self.email.isEmpty, self.password.isEmpty {
            alert(title: "Error", message: "Fill in all the fields")
        } else {
            successfulCondition = true
            alert(title: "Successful login", message: "")
        }
        return successfulCondition
    }

    private func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive)
        self.present(alertController, animated: true)
        alertController.addAction(okAction)
    }

    //MARK: - Actions

    @IBAction func loginButtonTapped(_ sender: Any?) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }

    }


}
