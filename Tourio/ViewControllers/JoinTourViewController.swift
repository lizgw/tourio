//
//  NearbyToursViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MapKit

class JoinTourViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nearbyTableView: UITableView!
    @IBOutlet weak var tourCodeTextField: UITextField!
    
    var tourList: [Tour] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup table view
        nearbyTableView.dataSource = self
        
        // get nearby tours - TODO: move this to a different place with network requests
        populateNearbyToursList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchTours()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // a row for each tour in the current list
        return tourList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tourCell", for: indexPath)
        
        let tour = tourList[indexPath.row]
        
        cell.textLabel?.text = tour.name
        // get the tour's distance away
        // get the delegate
        var distAwayString = "?"
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let lastCoord = delegate.locManager?.location?.coordinate
        if let lastCoord = lastCoord {
            let dist = tour.getDistanceAway(userPos: lastCoord)
            // if it's farther away than a mile
            if dist > 5280 {
                distAwayString = "\(feetToMiles(feet: dist)) mi"
            } else {
                distAwayString = "\(dist) ft"
            }
        }
        
        cell.detailTextLabel?.text = "by \(tour.createdBy) - \(distAwayString) away"
        
        return cell
    }
    
    func feetToMiles(feet: Double) -> Double {
        return feet * 0.000189394
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
                for document in querySnapshot!.documents {
                    // get the tour data
                    let data = document.data()
                    
                    // STOP if that tour is already in our list
                    if self.tourExists(withID: document.documentID) {
                        continue
                    }
                    
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
                                if let point = TourPoint(dictionary: doc.data(), id: doc.documentID, tourID: document.documentID) {
                                    points.append(point)
                                } else {
                                    print("error creating point")
                                }
                            }
                            
                            // create a new tour
                            if let newTour = Tour(dictionary: data, pointCollection: points, id: document.documentID) {
                                self.tourList.append(newTour)
                            } else {
                                print("Tour init failed")
                            }
                            
                            self.populateNearbyToursList()
                        }
                    }
                } // end for each document
            }
        }
    }
    
    func tourExists(withID searchID: String) -> Bool {
        for tour in tourList {
            if tour.id == searchID {
                return true
            }
        }
        
        return false
    }
    
    func populateNearbyToursList() {
        print(tourList)
        nearbyTableView.reloadData()
    }
    
    @IBAction func joinButtonPressed(_ sender: Any) {
        guard let tourCode = tourCodeTextField.text else { return }
        
        if (tourCode != "") {
            print("joined tour \(tourCode)")
        } else {
            print("Enter a tour code!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if we're going to the details segue
        if (segue.identifier == "JoinToDetailsSegue") {
            // get the tour object from the cell sender
            guard let cell = sender as? UITableViewCell,
                let tableView = cell.superview as? UITableView,
                let path = tableView.indexPath(for: cell) else { return }
            let tourObj = tourList[path.row]
            
            // check type for view controller
            guard let detailsVC = segue.destination as? TourDetailsViewController else { return }
            // set the view controller's tour property
            detailsVC.tour = tourObj
        }
    }
}
