//
//  NearbyToursViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class JoinTourViewController: UIViewController, TourListingViewProtocol {

    @IBOutlet weak var tourCodeTextField: UITextField!
    @IBOutlet weak var nearbyStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup the stack view
        nearbyStackView.spacing = 5
        
        // get nearby tours - TODO: move this to a different place with network requests
        populateNearbyToursList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func populateNearbyToursList() {
        // clear out the stack view to find the new nearby views
        for subview in nearbyStackView.arrangedSubviews {
            nearbyStackView.removeArrangedSubview(subview)
        }
        print("cleared out the view: \(nearbyStackView.arrangedSubviews)")
        
        // find tour objects and put them in a list
        let nearbyTours: [Tour] = getNearbyTours()
        
        // for each tour, make a TourListingView and add it to the stack view
        for tour in nearbyTours {
            let tourView = tour.getTourListingView()
            tourView.delegate = self
            nearbyStackView.addArrangedSubview(tourView)
        }
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
