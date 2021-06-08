//
//  NewComment.swift
//  GuestBook
//
//  Created by iOS NavekSoft on 8.06.21.
//

import UIKit

class NewComment: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var commentTextField: MyTextField!
    //MARK: - Variables
    
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
    
    @IBAction func addCommennt(_ sender: Any) {
        
    }
}
