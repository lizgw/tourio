//
//  TourPointListingView.swift
//  Tourio_i2
//
//  Created by Wigglesworth, Elizabeth G on 11/8/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class TourPointListingView: UIStackView {
    
    // holds all data
    let point: TourPoint
    let currentPos: CLLocationCoordinate2D
    
    init(fromPoint: TourPoint, currentPos: CLLocationCoordinate2D) {
        self.point = fromPoint
        self.currentPos = currentPos
        super.init(frame: CGRect.zero)
        setupElements()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements() {
        // layout this stack horizontally
        self.axis = .horizontal
        self.spacing = 10
        self.distribution = .equalSpacing
        
        let pointNameLabel = UILabel()
        pointNameLabel.text = point.title
        
        let distAwayLabel = UILabel()
        distAwayLabel.text = "\(getDistanceAway()) m away"
        
        addArrangedSubview(pointNameLabel)
        addArrangedSubview(distAwayLabel)
    }
    
    func getDistanceAway() -> Double {
        // create 2 locations
        let currentLoc = CLLocation(latitude: currentPos.latitude, longitude: currentPos.longitude)
        let pointLoc = CLLocation(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
        return currentLoc.distance(from: pointLoc) // in meters
    }
    
}
