//
//  TourDetailsViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class TourDetailsViewController: UIViewController {

    var tour: Tour = Tour(createdBy: "DEFAULT", isOrdered: true)
    
    @IBOutlet weak var tourIcon: UIImageView!
    @IBOutlet weak var tourNameLabel: UILabel!
    @IBOutlet weak var tourDetailsLabel: UILabel!
    @IBOutlet weak var tourDescriptionLabel: UILabel!
    @IBOutlet weak var addPointsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem!.isEnabled = false
        addPointsButton.isEnabled = false
        
        showTourDetails()
        showEditTools()
    }
    
    func showTourDetails() {
        tourIcon.image = UIImage(named: tour.iconPath)
        tourNameLabel.text = tour.name
        tourDetailsLabel.text = "by \(tour.createdBy) - \(tour.distanceAway) mi away"
        tourDescriptionLabel.text = tour.desc
    }
    
    func showEditTools() {
        //TODO: Change "Ryan" to be current username.
        guard tour.createdBy == "Ryan" else {
            return
        }
        
        navigationItem.rightBarButtonItem!.isEnabled = true
        addPointsButton.isEnabled = true
    }
    
    @IBAction func joinTourPressed(_ sender: Any) {
        print("Join Tour pressed")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PointListTableViewController else {
            return
        }
        
        destination.currentTour = tour
    }

}
