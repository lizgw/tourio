//
//  AddPointViewController.swift
//  Tourio
//
//  Created by Ryan Talbot on 5/10/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import MapKit

class AddPointViewController: UIViewController {

    var coordinate : CLLocationCoordinate2D?
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let coordinate = coordinate else {
            locationLabel.isEnabled = false
            locationLabel.text = ""
            coordinateLabel.isEnabled = false
            return
        }
        locationLabel.isEnabled = true
        locationLabel.text = "Location: "
        
        coordinateLabel.isEnabled = true
        coordinateLabel.text = "\(Double(round(1000 * coordinate.latitude)/1000)), \(Double(round(1000*coordinate.longitude)/1000))"
        
    }

    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
