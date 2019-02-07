//
//  MapPoint.swift
//  MapPointTest
//
//  Created by Wigglesworth, Elizabeth G on 10/17/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapPointView: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
