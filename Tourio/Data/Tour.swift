//
//  Tour.swift
//  Tourio_i2
//
//  Created by Wigglesworth, Elizabeth G on 11/8/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import UIKit
import MapKit

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
    
    func getPointList() -> [TourPoint] {
        return pointCollection.points
    }
    
    func addPoint(_ point: TourPoint) {
        pointCollection.addPoint(point)
    }
    
    // distance from current location to first point (if ordered) or nearest point
    func getDistanceAwayString() -> String {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        guard let userPos = delegate.locManager?.location?.coordinate else { return "?" }
        
        // find the nearest point to the user's pos
        var closestDist = Double.infinity // will be replaced by the closest dist
        for point in pointCollection.points {
            let pointDist = point.getDistanceAway(from: userPos)
            if pointDist < closestDist {
                closestDist = pointDist
            }
        }
        
        var distAwayString = ""
        // if it's farther away than a mile
        if closestDist > 5280 {
            distAwayString = "\(Tour.truncateDouble(num: Tour.feetToMiles(feet: closestDist), accuracy: 100)) mi"
        } else {
            distAwayString = "\(Tour.truncateDouble(num: closestDist, accuracy: 100)) ft"
        }
        
        // use that distance
        return distAwayString
    }
    
    static func feetToMiles(feet: Double) -> Double {
        return feet * 0.000189394
    }
    
    static func truncateDouble(num: Double, accuracy: Double) -> Double {
        return Double(floor(num * accuracy) / accuracy)
    }
    
}
