//
//  AddThougthVC.swift
//  FireStore
//
//  Created by Kostyantyn Runduyev on 2/21/18.
//  Copyright © 2018 Kostyantyn Runduyev. All rights reserved.
//

import UIKit
import Firebase

class AddThougthVC: UIViewController {
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var thoughtsTextView: UITextView!
    @IBOutlet private weak var postBtn: UIButton!
    
    //Varibles
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4
        thoughtsTextView.layer.cornerRadius = 4
        thoughtsTextView.text = "My random thought..."
        thoughtsTextView.textColor = UIColor.lightGray
        thoughtsTextView.delegate = self
    }

    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        guard let username = userNameTextField.text else { return }
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            THOUGHT_TEXT : thoughtsTextView.text,
            TIMESTAMP : Date.init(),
            USERNAME : username
        ]) { (error) in
            if let error = error {
                debugPrint("error \(error)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

extension AddThougthVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        thoughtsTextView.text = ""
        thoughtsTextView.textColor = UIColor.darkGray
    }
    
}
