//
//  ThoughtCell.swift
//  FireStore
//
//  Created by Kostyantyn Runduyev on 2/21/18.
//  Copyright © 2018 Kostyantyn Runduyev. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTextLabel: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesNumLabel: UILabel!
    
    // Variables
    private var thought: Thought!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true
    }
    
    @objc func likeTapped() {
//        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentID).setData([NUM_LIKES : thought.numLikes + 1], options: SetOptions.merge())
        
        // Method 2
        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentID).updateData([NUM_LIKES : thought.numLikes + 1])

    }

    func configureCell(thought: Thought) {
        self.thought = thought
        usernameLabel.text = thought.username
        thoughtTextLabel.text = thought.thoughtTxt
        likesNumLabel.text = String(thought.numLikes)
        
        let formater = DateFormatter()
        formater.dateFormat = "MMM d, hh:mm"
        timestampLbl.text = formater.string(from: thought.timestamp)

    }

    
}
