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
    
    @IBAction func addAnswerButtonTapped(_ sender: Any) {
    }
    
}
