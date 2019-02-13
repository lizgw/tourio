//
//  Tour.swift
//  Tourio_i2
//
//  Created by Wigglesworth, Elizabeth G on 11/8/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import UIKit

class Tour {
    
    // main/meta properties
    var name: String = ""
    var createdBy: String
    var desc: String = ""
    var iconPath: String = ""
    var isOrdered: Bool = true
    
    // data
    var pointCollection: TourPointCollection
    
    // --- computed properties ---
    // distance from current location to first point (if ordered) or nearest point
    var distanceAway: Double {
        return 0.0
    }
    
    // linear distance from A to B to C... etc.
    // best for ordered tours
    var totalDistanceCovered: Double {
        return 0.0
    }
    
    // how much space is covered on the map
    // best for unordered tours
    var totalAreaCovered: Double {
        return 0.0
    }
    
    // --- initializers ---
    
    // createdBy is the only property that gets initialized immediately
    // everything else is set to default and updated as the tour is created
    init(createdBy: String, isOrdered: Bool) {
        // setup main properties
        self.createdBy = createdBy
        self.isOrdered = isOrdered
        
        // create an empty tour point collection
        pointCollection = TourPointCollection(isOrdered: isOrdered)
    }
    
    // --- methods ---
    
    // returns a TourListingView representing this Tour
    func getTourListingView() -> TourListingView {
        // init a TourListingView
        let tourView = TourListingView(tour: self)
        
        return tourView
    }
    
}
