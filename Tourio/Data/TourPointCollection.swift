//
//  TourPointCollection.swift
//  Tourio_i2
//
//  Created by Wigglesworth, Elizabeth G on 11/8/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import CoreLocation

class TourPointCollection: CustomStringConvertible {
    
    // data
    var points: [TourPoint]
    var isOrdered: Bool
    
    var description: String {
        var result = "->"
        
        for point in self.points {
            result += point.title + ", "
        }
        
        return "\(points)"
    }
    
    // --- initializers ---
    
    init(isOrdered: Bool) {
        points = [TourPoint]()
        self.isOrdered = isOrdered
    }
    
    // --- methods ---
    // returns point i in the list
    func getPoint(atIndex: Int) -> TourPoint {
        // TODO: error checking (out of bounds, etc.)
        return points[atIndex]
    }
    
    func addPoint(_ point: TourPoint) {
        points.append(point)
    }
    
    // get point by ID?
    // get point by name?
    
    // return the point nearest to the coordinate
    /*func getNearestPoint(coordinate: CLLocationCoordinate2D) -> TourPoint {
        // TODO
        return TourPoint()
    }*/
    
}
