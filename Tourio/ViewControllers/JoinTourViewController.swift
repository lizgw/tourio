//
//  NearbyToursViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class JoinTourViewController: UIViewController {

    @IBOutlet weak var tourCodeTextField: UITextField!
    @IBOutlet weak var nearbyStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup the stack view
        nearbyStackView.spacing = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateNearbyToursList()
    }
    
    func populateNearbyToursList() {
        // find tour objects and put them in a list
        let nearbyTours: [Tour] = getNearbyTours()
        
        // for each tour, make a TourListingView and add it to the stack view
        for tour in nearbyTours {
            nearbyStackView.addArrangedSubview(tour.getTourListingView())
        }
    }
    
    func getNearbyTours() -> [Tour] {
        var tourList = [Tour]()
        
        // TEMPORARY: make 5 random tours
        for _ in 0...4
        {
            let randUsername = "user\(arc4random_uniform(100))"
            let isOrdered: Bool = arc4random_uniform(2) == 0 ? true : false
            let tour = Tour(createdBy: randUsername, isOrdered: isOrdered)
            tour.name = "Tour Name"
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

}
