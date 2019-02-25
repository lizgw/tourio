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
        
        // check units
        var dist = getDistanceAway()
        var unit = "ft"
        // if it's more than a half mile away
        if dist >= 2640 {
            // display miles instead of feet
            unit = "mi"
            dist /= 5280
        }
        distAwayLabel.text = "\(dist) \(unit) away"
        
        addArrangedSubview(pointNameLabel)
        addArrangedSubview(distAwayLabel)
    }
    
    func getDistanceAway() -> Double {
        // create 2 locations
        let currentLoc = CLLocation(latitude: currentPos.latitude, longitude: currentPos.longitude)
        let pointLoc = CLLocation(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
        let distVal = currentLoc.distance(from: pointLoc) * 3.28084 // meters to ft
        let accuracy = 100.0
        return Double(floor(distVal * accuracy) / accuracy) // fancy math trick to truncate the double
    }
    
}
