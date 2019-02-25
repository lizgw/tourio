//
//  ProfileViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 1/30/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, TourListingViewProtocol {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var myToursStackView: UIStackView!
    
    var username = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for demo, actual username from network
        username = "user\(Int.random(in: 1...100))"
        
        displayInfo()
    }
    
    func displayInfo() {
        // display the username
        usernameLabel.text = username
        
        // get the profile image
        profileImageView.image = UIImage(named: "UserIcon", in: nil, compatibleWith: nil)
        
        // create a few random tours to show in the profile
        for tourNum in 1...4 {
            // make a random tour
            let tour = Tour(createdBy: username, isOrdered: true)
            tour.name = "Tour \(tourNum)\(Int.random(in: 1...100))"
            tour.desc = "This is a basic tour description"
            tour.iconPath = "UserIcon"
            
            // add the TourListingView to the stack view
            let tourView = tour.getTourListingView()
            tourView.delegate = self
            myToursStackView.addArrangedSubview(tourView)
        }
    }
    
    func tourListingViewTapped(tour: Tour) {
        // go to the details screen when a listing view is tapped
        performSegue(withIdentifier: "ProfileToDetailsSegue", sender: tour)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if we're going to the details segue
        if (segue.identifier == "ProfileToDetailsSegue") {
            
            // check type for view controller and the Tour
            guard let detailsVC = segue.destination as? TourDetailsViewController,
                let tourObj = sender as? Tour else { return }
            // set the view controller's tour property
            detailsVC.tour = tourObj
        }
    }
    
}
