//
//  TourViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 1/30/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TourViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var currentTour: Tour? = nil
    var pointsAdded = false
    var locManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapSetup()
    }
    
    func locationSetup() {
        // get the delegate
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if let locMgr = delegate.locManager {
            locManager = locMgr
        }
    }
    
    func mapSetup() {
        // setup map appearance
        mapView.mapType = .hybrid
        mapView.showsUserLocation = true
        mapView.isPitchEnabled = false
        // TODO: live update map with heading
        
        // how far the map spans
        let viewSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        // center the map on the current location
        if let mostRecentLocation = locManager.location {
            let currentPos = mostRecentLocation.coordinate
            let viewRegion = MKCoordinateRegion(center: currentPos, span: viewSpan)
            mapView.setRegion(viewRegion, animated: true)
        } else {
            print("there is no most recent location")
        }
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let delegateTour = delegate.currentTour
        if !pointsAdded || delegateTour?.id != currentTour?.id {
            addPoints()
        }
    }
    
    // add the annotations for the current tour
    func addPoints() {        
        // get the current tour from the delegate!!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        currentTour = appDelegate.currentTour
        
        // don't try to add points from the tour if it doesn't exist
        guard let currentTour = currentTour else {
            // remove all points
            clearAnnotations()
            
            // don't add any points
            return
        }
        
        clearAnnotations()
        
        for point in currentTour.getPointList() {
            // only display the point if it's hidden and within range OR not hidden
            if point.withinRange() {
                mapView.addAnnotation(point.getMapPointView())
            }
        }
        
        pointsAdded = true
    }
    
    func clearAnnotations() {
        // clear the previous annotations
        let annotations = mapView.annotations.filter {
            $0 !== self.mapView.userLocation
        }
        mapView.removeAnnotations(annotations)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PointListSegue" {
            if let pointListVC = segue.destination as? PointListTableViewController {
                pointListVC.currentTour = currentTour
                
                // send the coordinate of the current location to the VC
                if let coord = locManager.location?.coordinate {
                    pointListVC.currentCoordinate = coord
                }
            }
        }
    }

}
