//
//  AppPointMapViewController.swift
//  Tourio
//
//  Created by Ryan Talbot on 5/10/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import MapKit

class AddPointMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var annotation : MKPointAnnotation?
    var locManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(AddPointMapViewController.handleTap(_:)))
        gestureRecognizer.minimumPressDuration = 1
        mapView.addGestureRecognizer(gestureRecognizer)
        
        locationSetup()
    }
    
    func locationSetup() {
        locManager = CLLocationManager()
        locManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapSetup()
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
    }

    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer)
    {
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        annotation = MKPointAnnotation()
        
        guard let annotation = annotation else {
            return
        }
        
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        print("Processed")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let destination = self.navigationController!.viewControllers.last! as? AddPointViewController,
        let annotation = annotation else {
            return
        }
        
        destination.coordinate = annotation.coordinate
    }
    
}
