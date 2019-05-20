//
//  TourPoint.swift
//  Tourio_i2
//
//  Created by Wigglesworth, Elizabeth G on 11/8/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class TourPoint: CustomStringConvertible {
    
    // variables
    var coordinate: CLLocationCoordinate2D
    var title: String = ""
    var subtitle: String = ""
    var contents: [TourPointContent]
    var visited: Bool = false
    var hiddenUntilDiscovered: Bool = false
    var contentHiddenUntilDiscovered: Bool = true
    var id: String = ""
    var tourID: String = ""
    
    var description: String {
        return "\(title) at (\(coordinate.latitude), \(coordinate.longitude))"
    }
    
    // --- initializers ---
    // coordinate is the only var that needs to be immediately initalized with data
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
        // create the empty contents array
        contents = [TourPointContent]()
    }
    
    init(title: String, subtitle: String, visited: Bool, hiddenUntilDiscovered: Bool, contentHiddenUntilDiscovered: Bool, coordinate: CLLocationCoordinate2D, id: String, tourID: String) {
        self.title = title
        self.subtitle = subtitle
        self.visited = visited
        self.hiddenUntilDiscovered = hiddenUntilDiscovered
        self.contentHiddenUntilDiscovered = contentHiddenUntilDiscovered
        self.coordinate = coordinate
        self.id = id
        self.tourID = tourID
        
        contents = [TourPointContent]()
    }
    
    // for building a TourPoint from the database
    convenience init?(dictionary: [String : Any], id: String, tourID: String) {
        
        // get all the data from the dictionary & fail if it's missing anything
        guard let title = dictionary["title"] as? String,
            let latitude = dictionary["latitude"] as? Double,
            let longitude = dictionary["longitude"] as? Double
            // TODO: handle contents collection
            else { return nil }
        
        // set defaults for non-essential values
        var subtitle = ""
        var visited = false
        var hiddenUntilDiscovered = false
        var contentHiddenUntilDiscovered = true
        
        // read in these values if they exist
        if let subtitleData = dictionary["subtitle"] as? String {
            subtitle = subtitleData
        }
        if let visitedData = dictionary["visited"] as? Bool {
            visited = visitedData
        }
        if let hiddenUntilDiscoveredData = dictionary["hiddenUntilDiscovered"] as? Bool {
            hiddenUntilDiscovered = hiddenUntilDiscoveredData
        }
        if let contentHiddenUntilDiscoveredData = dictionary["contentHiddenUntilDiscovered"] as? Bool {
            contentHiddenUntilDiscovered = contentHiddenUntilDiscoveredData
        }
        
        // build a coordinate from the latitide & longitude
        let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // initialize everything
        self.init(title: title, subtitle: subtitle, visited: visited, hiddenUntilDiscovered: hiddenUntilDiscovered, contentHiddenUntilDiscovered: contentHiddenUntilDiscovered, coordinate: coord, id: id, tourID: tourID)
    }
    
    // --- methods ---
    // returns a MapPointView that represents this point
    func getMapPointView() -> MapPointView {
        return MapPointView(title: title, subtitle: subtitle, coordinate: coordinate)
    }
    
    func withinRange() -> Bool {
        // if we're not hiding it, it's automatically in range
        if (!hiddenUntilDiscovered) {
           return true
        // now we need to see if it's close enough to display
        } else {
            let rangeDist = 30.0 // ft
            // figure out where the user is
            let delegate = UIApplication.shared.delegate as! AppDelegate
            guard let userCoord = delegate.locManager?.location?.coordinate else { return false }
            let userDist = getDistanceAway(from: userCoord)
            if userDist < rangeDist {
                return true
            } else {
                return false
            }
        }
        
    }
    
    func getDistanceAway(from otherCoordinate: CLLocationCoordinate2D) -> Double {
        // create 2 locations
        let currentLoc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let pointLoc = CLLocation(latitude: otherCoordinate.latitude, longitude: otherCoordinate.longitude)
        return currentLoc.distance(from: pointLoc) * 3.28084 // meters to ft
    }
    
    func getDistanceAwayString(from otherCoordinate: CLLocationCoordinate2D) -> String {
        let dist = getDistanceAway(from: otherCoordinate)
        
        // convert to mi if too big
        if (dist > 5280) {
            return "\(Tour.truncateDouble(num: Tour.feetToMiles(feet: dist), accuracy: 100)) mi away"
        } else {
            return "\(Tour.truncateDouble(num: dist, accuracy: 100)) ft away"
        }
    }
    
}
