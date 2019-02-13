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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showTourDetails()
    }
    
    func showTourDetails() {
        print("Tour Name: \(tour.name)")
    }
    
    func buildUI() {
        print("built UI")
    }

}
