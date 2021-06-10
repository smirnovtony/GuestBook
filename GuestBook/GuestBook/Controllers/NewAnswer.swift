//
//  NewAnswer.swift
//  GuestBook
//
//  Created by iOS NavekSoft on 8.06.21.
//
import UIKit

class NewAnswer: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var answerTextField: MyTextField!
    
    //MARK: - Variables
    
    var postId: Int?
    private var answerText: String {
        self.answerTextField.text ?? ""
    }
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
    }
    
    private func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive)
        self.present(alertController, animated: true)
        alertController.addAction(okAction)
    }
    
    @IBAction func addAnswerButtonTapped(_ sender: Any) {
        if answerText.isEmpty {
            alert(title: "Error", message: "Message is empty!")
        } else {
            guard let postIdentify = postId else { return }
            let postIdAsString = String(postIdentify)
            NetworkManager.shared.addAnswer(post: postIdAsString, message: answerText) { (success) in
                self.performSegue(withIdentifier: "updatePosts", sender: self)
            }
        }
    }
}

