//
//  HomeViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 1/30/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var onTour = false
    
    @IBOutlet weak var quitTourButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loaded home view")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // enable the quit button only if we're on a tour
        if (onTour) {
            quitTourButton.isEnabled = true
        } else {
            quitTourButton.isEnabled = false
        }
    }

}

