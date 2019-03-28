//
//  PointListTableViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 3/28/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import CoreLocation

class PointListTableViewController: UITableViewController {

    var currentTour: Tour?
    var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // only 1 section here
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // one for each point in the tour
            if let currentTour = currentTour {
                return currentTour.getPointList().count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pointCell", for: indexPath)
        
        if let currentTour = currentTour {
            let point = currentTour.getPointList()[indexPath.row]
            
            cell.textLabel?.text = "\(point.title)"
            cell.detailTextLabel?.text = "0.0 mi away" // TODO: calculate actual distance
        }

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
