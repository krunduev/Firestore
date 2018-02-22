//
//  Thought.swift
//  FireStore
//
//  Created by Kostyantyn Runduyev on 2/21/18.
//  Copyright © 2018 Kostyantyn Runduyev. All rights reserved.
//

import Foundation
import Firebase

class Thought {
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var thoughtTxt: String!
    private(set) var numLikes: Int!
    private(set) var numComments: Int!
    private(set) var documentID: String!
    
    init(username: String, timestamp: Date, thoughtTxt: String, numLikes: Int, numComments: Int, documentID: String) {
        self.username = username
        self.timestamp = timestamp
        self.thoughtTxt = thoughtTxt
        self.numLikes = numLikes
        self.numComments = numComments
        self.documentID = documentID
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Thought] {
        var thoughts = [Thought]()
        
        guard let snap = snapshot else { return thoughts }
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonimous"
            let timestamp = data[TIMESTAMP] as? Date ?? Date.init(timeIntervalSince1970: 0)
            let thoughtText = data[THOUGHT_TEXT] as? String ?? ""
            let numLikes = data[NUM_LIKES] as? Int ?? 0
            let numComments = data[NUM_COMMENTS] as? Int ?? 0
            let documentID = document.documentID
            
            let newThought = Thought.init(username: username, timestamp: timestamp, thoughtTxt: thoughtText, numLikes: numLikes, numComments: numComments, documentID: documentID)
            
            thoughts.append(newThought)
        }
        
        return thoughts
    }
}
