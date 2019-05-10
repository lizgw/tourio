//
//  PointDetailsViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import Firebase

class PointDetailsViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    var point: TourPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupDisplay()
    }
    
    func setupDisplay() {
        guard let point = point else { return }
        
        title = point.title
        
        if point.id == "" {
            textLabel.text = "No information was entered for this point."
        } else {
            // get the data from the database & display the text!
            let tourCollection = Firestore.firestore().collection("testTours")
            let tour = tourCollection.document(point.tourID)
            let pointDoc = tour.collection("points").document(point.id)
            
            pointDoc.getDocument() { (docSnapshot, err) in
                if let docSnapshot = docSnapshot,
                    docSnapshot.exists,
                    let data = docSnapshot.data(),
                    let text = data["textContent"] as? String
                {
                    self.textLabel.text = text
                }
            }
        }
    }

}
