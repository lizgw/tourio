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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showTourDetails()
    }
    
    func showTourDetails() {
        tourIcon.image = UIImage(named: tour.iconPath)
        tourNameLabel.text = tour.name
        
        // get the tour's distance away
        // get the delegate
        var distAwayString = "?"
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let lastCoord = delegate.lastCoordinate
        if let lastCoord = lastCoord {
            distAwayString = "\(tour.getDistanceAway(userPos: lastCoord))"
        }
        tourDetailsLabel.text = "by \(tour.createdBy) - \(distAwayString) mi away"
        
        tourDescriptionLabel.text = tour.desc
    }
    
    @IBAction func joinTourPressed(_ sender: Any) {
        // set it in the delegate
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.currentTour = tour
        print("joined tour \(tour.id)")
    }

}
