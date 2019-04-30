//
//  NearbyToursViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import FirebaseFirestore

class JoinTourViewController: UIViewController, TourListingViewProtocol, UITableViewDataSource {

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
        cell.detailTextLabel?.text = "by \(tour.createdBy) - \(tour.distanceAway) mi away"
        
        return cell
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
                                print("using data: \(doc.data())")
                                if let point = TourPoint(dictionary: doc.data()) {
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
        
        // clear out the stack view to find the new nearby views
        /*for subview in nearbyStackView.arrangedSubviews {
            nearbyStackView.removeArrangedSubview(subview)
        }*/
        //print("cleared out the view: \(nearbyStackView.arrangedSubviews)")
        
        // for each tour, make a TourListingView and add it to the stack view
        /*for tour in tourList {
            let tourView = tour.getTourListingView()
            tourView.delegate = self
            nearbyStackView.addArrangedSubview(tourView)
        }*/
    }
    
    func getNearbyTours() -> [Tour] {
        var tourList = [Tour]()
        
        // TEMPORARY: make some random tours
        for _ in 1...6
        {
            let randUsername = "user\(arc4random_uniform(100))"
            let isOrdered: Bool = arc4random_uniform(2) == 0 ? true : false
            let tour = Tour(createdBy: randUsername, isOrdered: isOrdered)
            tour.name = "Tour \(arc4random_uniform(100))"
            tour.iconPath = "UserIcon"
            tour.desc = "This is the tour's default description."
            tourList.append(tour)
        }
        
        return tourList
    }
    
    @IBAction func joinButtonPressed(_ sender: Any) {
        guard let tourCode = tourCodeTextField.text else { return }
        
        if (tourCode != "") {
            print("joined tour \(tourCode)")
        } else {
            print("Enter a tour code!")
        }
    }
    
    func tourListingViewTapped(tour: Tour) {
        // go to the details screen when a listing view is tapped
        performSegue(withIdentifier: "JoinToDetailsSegue", sender: tour)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if we're going to the details segue
        if (segue.identifier == "JoinToDetailsSegue") {
            
            // check type for view controller and the Tour
            guard let detailsVC = segue.destination as? TourDetailsViewController,
                let tourObj = sender as? Tour else { return }
            // set the view controller's tour property
            detailsVC.tour = tourObj
        }
    }
}
