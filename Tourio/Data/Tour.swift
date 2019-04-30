//
//  Tour.swift
//  Tourio_i2
//
//  Created by Wigglesworth, Elizabeth G on 11/8/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import UIKit

class Tour : CustomStringConvertible {
    
    // main/meta properties
    var name: String = ""
    var createdBy: String
    var desc: String = ""
    var iconPath: String = ""
    var isOrdered: Bool = true
    var id: String = ""
    
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
    
    var description: String {
        //return "--- TOUR ---\nname: \(name)\n...\npoint collection: \(pointCollection)"
        return "{ TOUR: \(name) }"
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
    
    init(name: String, createdBy: String, desc: String, iconPath: String, isOrdered: Bool) {
        // setup everything
        self.name = name
        self.createdBy = createdBy
        self.desc = desc
        self.iconPath = iconPath
        self.isOrdered = isOrdered
        
        pointCollection = TourPointCollection(isOrdered: isOrdered)
    }
    
    convenience init?(dictionary: [String : Any], pointCollection: [TourPoint], id: String)
    {
        // get all the info from the dictionary & fail if any field is missing
        guard let name = dictionary["name"] as? String,
            let createdBy = dictionary["createdBy"] as? String,
            let desc = dictionary["desc"] as? String,
            let iconPath = dictionary["desc"] as? String,
            let isOrdered = dictionary["isOrdered"] as? Bool
            else { return nil}
        
        // if all that worked, init!
        self.init(name: name, createdBy: createdBy, desc: desc, iconPath: iconPath, isOrdered: isOrdered)
        
        self.id = id
        
        // set up the point collection
        for point in pointCollection {
            addPoint(point)
        }
    }
    
    // --- methods ---
    
    // returns a TourListingView representing this Tour
    func getTourListingView() -> TourListingView {
        // init a TourListingView
        let tourView = TourListingView(tour: self)
        
        return tourView
    }
    
    func getPointList() -> [TourPoint] {
        return pointCollection.points
    }
    
    func addPoint(_ point: TourPoint) {
        pointCollection.addPoint(point)
    }
    
}
