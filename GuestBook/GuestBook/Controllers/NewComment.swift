//
//  NewComment.swift
//  GuestBook
//
//  Created by iOS NavekSoft on 8.06.21.
//

import UIKit

class NewComment: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleTextField: MyTextField!
    @IBOutlet weak var commentTextField: MyTextField!
    
    //MARK: - Variables
    
    private var commentTitle: String {
        self.titleTextField.text ?? ""
    }
    private var commentText: String {
        self.commentTextField.text ?? ""
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
    
    @IBAction func addCommennt(_ sender: Any) {
        if commentTitle.isEmpty || commentText.isEmpty {
            print(commentTitle, commentText)
            alert(title: "Error", message: "Fill in all the fields!")
        } else {
            NetworkManager.shared.addComment(with: commentTitle, message: commentText) { (success) in
                self.performSegue(withIdentifier: "reloadPosts", sender: self)
            }
        }
    }
}
