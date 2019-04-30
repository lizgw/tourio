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
        
        fetchTours()
    }
    
    func fetchTours() {
        let tourCollection = Firestore.firestore().collection("testTours")
        // get all the tours
        tourCollection.getDocuments() { (querySnapshot, err) in
            // handle error
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // create a tour for each document
                var tours: [Tour] = [Tour]()
                for document in querySnapshot!.documents {
                    // get the tour data
                    let data = document.data()
                    // get the point collection
                    let pointCol = tourCollection.document(document.documentID).collection("points")
                    
                    var points: [TourPoint] = [TourPoint]()
                    // go through the collection & build all the points
                    pointCol.getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print(err)
                        } else {
                            for doc in querySnapshot!.documents {
                                // create a point
                                if let point = TourPoint(dictionary: doc.data()) {
                                    points.append(point)
                                } else {
                                    print("error creating point")
                                }
                            }
                            
                            // create a new tour
                            if let newTour = Tour(dictionary: data, pointCollection: points) {
                                tours.append(newTour)
                            } else {
                                print("Tour init failed")
                            }
                        }
                        // do something!!
                        for tour in tours {
                            print(tour)
                        }
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

