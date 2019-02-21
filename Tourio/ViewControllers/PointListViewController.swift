//
//  PointListViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class PointListViewController: UIViewController {
    
    var currentTour: Tour?
    
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
            stackView.addArrangedSubview(point.getTourPointListingView())
        }
    }

}
