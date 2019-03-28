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

class TourViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locManager: CLLocationManager!
    var currentTour: Tour? = nil
    var pointsAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapSetup()
    }
    
    func locationSetup() {
        locManager = CLLocationManager()
        locManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
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
        
        if !pointsAdded {
            addPoints()
        }
    }
    
    // add the annotations for the current tour
    func addPoints() {
        createDemoTour() // for testing
        
        // don't try to add points from the tour if it doesn't exist
        guard let currentTour = currentTour else { return }
        
        print(currentTour.getPointList())
        for point in currentTour.getPointList() {
            mapView.addAnnotation(point.getMapPointView())
        }
        
        pointsAdded = true
    }
    
    // build a demo tour for debugging
    func createDemoTour() {
        // create the tour
        currentTour = Tour(createdBy: "testuser", isOrdered: true)
        
        // make sure it exists & configure it...
        guard let currentTour = currentTour else { return }
        
        if let currentPos = locManager.location?.coordinate {
            // create a bunch of random points
            let letters = ["a", "b", "c", "d", "e", "f", "g"]
            for i in 1...5 {
                // generate a random fraction
                let isNegative = arc4random_uniform(2)
                let isNegative2 = arc4random_uniform(2)
                
                var randNum: Double = Double(arc4random_uniform(100)) * 0.00001
                var randNum2 = randNum
                if isNegative < 1 {
                    randNum *= -1
                }
                if isNegative2 < 1 {
                    randNum2 *= -1
                }
                // modify the current coordinates a bit
                let lat = currentPos.latitude + randNum
                let long = currentPos.longitude + randNum2
                
                // make a new point and add it to the tour
                let point = TourPoint(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: long))
                point.title = "Point \(letters[i - 1].uppercased())"
                currentTour.addPoint(point)
            }
        } else {
            print("no location???")
        }
    }
    
    // handle errors from the location manager
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // get the last location from the manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /*let lastLocation = locations[locations.count - 1]
        print(lastLocation.coordinate)*/
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
