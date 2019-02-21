//
//  TourPoint.swift
//  Tourio_i2
//
//  Created by Wigglesworth, Elizabeth G on 11/8/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import CoreLocation

class TourPoint {
    
    // variables
    var coordinate: CLLocationCoordinate2D
    var title: String = ""
    var subtitle: String = ""
    var contents: [TourPointContent]
    var visited: Bool = false
    var hiddenUntilDiscovered: Bool = false
    var contentHiddenUntilDiscovered: Bool = true
    
    // --- initializers ---
    // coordinate is the only var that needs to be immediately initalized with data
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
        // create the empty contents array
        contents = [TourPointContent]()
    }
    
    // --- methods ---
    // returns a MapPointView that represents this point
    func getMapPointView() -> MapPointView {
        return MapPointView(title: title, subtitle: subtitle, coordinate: coordinate)
    }
    
    // returns a TourPointListingView that represents this point
    func getTourPointListingView(currentPos: CLLocationCoordinate2D) -> TourPointListingView {
        return TourPointListingView(fromPoint: self, currentPos: currentPos)
    }
    
}
