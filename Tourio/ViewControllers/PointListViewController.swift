//
//  PointListViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import CoreLocation

class PointListViewController: UIViewController {
    
    var currentTour: Tour?
    var currentCoordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentTour = currentTour {
            print(currentTour.name)
        } else {
            print("no current tour")
        }
        
        buildPointList()
    }
    
    func buildPointList() {
        // for every point in the tour, build & show a TourPointListingView
        guard let currentTour = currentTour else { return }
        
        for point in currentTour.getPointList() {
            if let currentCoordinate = currentCoordinate {
                stackView.addArrangedSubview(point.getTourPointListingView(currentPos: currentCoordinate))
            }
        }
    }

}
