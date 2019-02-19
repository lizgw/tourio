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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationSetup()
        mapSetup()
        addPoints()
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
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        
        // how far the map spans
        let viewSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        // center the map on the current location
        if let currentPos = locManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: currentPos, span: viewSpan)
            mapView.setRegion(viewRegion, animated: true)
        }
    }
    
    // add the annotations for the current tour
    func addPoints() {
        // TODO: if on tour...
        // build a test point
        let testCoord = CLLocationCoordinate2D(latitude: 33.1348324, longitude: -96.7718147)
        let testPoint = MapPointView(title: "Test point", subtitle: "this is a test!", coordinate: testCoord)
        
        // add it to the map
        mapView.addAnnotation(testPoint)
    }
    
    // handle errors from the location manager
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // get the last location from the manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations[locations.count - 1]
        print(lastLocation.coordinate)
    }

}
