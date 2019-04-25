//
//  TourPoint.swift
//  Tourio_i2
//
//  Created by Wigglesworth, Elizabeth G on 11/8/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import CoreLocation

class TourPoint: CustomStringConvertible {
    
    // variables
    var coordinate: CLLocationCoordinate2D
    var title: String = ""
    var subtitle: String = ""
    var contents: [TourPointContent]
    var visited: Bool = false
    var hiddenUntilDiscovered: Bool = false
    var contentHiddenUntilDiscovered: Bool = true
    
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
    
    init(title: String, subtitle: String, visited: Bool, hiddenUntilDiscovered: Bool, contentHiddenUntilDiscovered: Bool, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.visited = visited
        self.hiddenUntilDiscovered = hiddenUntilDiscovered
        self.contentHiddenUntilDiscovered = contentHiddenUntilDiscovered
        self.coordinate = coordinate
        
        contents = [TourPointContent]()
    }
    
    // for building a TourPoint from the database
    convenience init?(dictionary: [String : Any]) {
        // get all the data from the dictionary & fail if it's missing anything
        guard let title = dictionary["title"] as? String,
            let subtitle = dictionary["subtitle"] as? String,
            let visited = dictionary["visited"] as? Bool,
            let hiddenUntilDiscovered = dictionary["hiddenUntilDiscovered"] as? Bool,
            let contentHiddenUntilDiscovered = dictionary["contentHiddenUntilDiscovered"] as? Bool,
            let latitude = dictionary["latitude"] as? Double,
            let longitude = dictionary["longitude"] as? Double
            // TODO: handle contents collection
            else { return nil }
        
        // build a coordinate from the latitide & longitude
        let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // initialize everything
        self.init(title: title, subtitle: subtitle, visited: visited, hiddenUntilDiscovered: hiddenUntilDiscovered, contentHiddenUntilDiscovered: contentHiddenUntilDiscovered, coordinate: coord)
    }
    
    // --- methods ---
    // returns a MapPointView that represents this point
    func getMapPointView() -> MapPointView {
        return MapPointView(title: title, subtitle: subtitle, coordinate: coordinate)
    }
    
    func getDistanceAway(from otherCoordinate: CLLocationCoordinate2D) -> Double {
        // create 2 locations
        let currentLoc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let pointLoc = CLLocation(latitude: otherCoordinate.latitude, longitude: otherCoordinate.longitude)
        let distVal = currentLoc.distance(from: pointLoc) * 3.28084 // meters to ft
        let accuracy = 100.0
        return Double(floor(distVal * accuracy) / accuracy) // fancy math trick to truncate the double
    }
    
}
