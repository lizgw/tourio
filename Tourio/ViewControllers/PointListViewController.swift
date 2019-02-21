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

    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentTour = currentTour {
            print(currentTour)
        } else {
            print("no current tour")
        }
    }

}
