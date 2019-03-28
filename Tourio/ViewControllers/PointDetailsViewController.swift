//
//  PointDetailsViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class PointDetailsViewController: UIViewController {

    var point: TourPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDisplay()
    }
    
    func setupDisplay() {
        guard let point = point else { return }
        
        title = point.title
    }

}
