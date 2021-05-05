//
//  RegisterVC.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import UIKit

class RegisterVC: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var choosePhotoImage: UIImageView! {
        didSet {
            choosePhotoImage.layer.cornerRadius = 50
        }
    }
    @IBOutlet weak var chooseYourPhotoButton: MyButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: MyTextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: MyTextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: MyTextField!

    //MARK: - Variables

    private var name: String {
        self.nameField.text ?? ""
    }
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

//    //MARK: - Functions
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
    }

    //MARK: - Actions

    @IBAction func chooseYourPhotoButtonTapped(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }

    @IBAction func registerButtonTapped(_ sender: Any?) {
        if logInConditions() {
//            self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        }
    }
    //MARK: - LogInConditions

    private func logInConditions() -> Bool {
        if self.name.isEmpty, self.email.isEmpty, self.password.isEmpty {
            alert(title: "Error", message: "Fill in all the fields")
        } else if self.name == self.password {
            alert(title: "Error", message: "The password must not be the same as the name")
        } else if self.email == self.password {
            alert(title: "Error", message: "The password must not be the same as the email")
        } else if !self.email.isEmpty, isValid(email) {
            alert(title: "Error", message: "Сheck the entered email")
        } else {
            successfulCondition = true
            alert(title: "Successful registration", message: "")
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

    private func isValid(_ email: String) -> Bool {
        // swiftlint:disable line_length
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

//MARK: - Extensions

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.choosePhotoImage.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
