//
//  HomeViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 1/30/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var quitTourButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // enable the quit button only if we're on a tour
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.currentTour != nil) {
            quitTourButton.isEnabled = true
        } else {
            quitTourButton.isEnabled = false
        }
    }

}

