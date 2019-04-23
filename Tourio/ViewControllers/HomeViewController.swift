//
//  HomeViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 1/30/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var onTour = false
    
    @IBOutlet weak var quitTourButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // test read some data from firebase
        let testCollection = Firestore.firestore().collection("users")
        
        // get documents
        testCollection.getDocuments() { (querySnapshot, err) in
            // handle the error
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // go through each document in the collection
                for document in querySnapshot!.documents {
                    // print it out
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loaded home view")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // enable the quit button only if we're on a tour
        if (onTour) {
            quitTourButton.isEnabled = true
        } else {
            quitTourButton.isEnabled = false
        }
    }

}

