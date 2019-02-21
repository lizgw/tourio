//
//  TourPointListingView.swift
//  Tourio_i2
//
//  Created by Wigglesworth, Elizabeth G on 11/8/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import Foundation
import UIKit

class TourPointListingView: UIStackView {
    
    // holds all data
    let point: TourPoint
    
    init(fromPoint: TourPoint) {
        self.point = fromPoint
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
        distAwayLabel.text = "\(point.distanceAway) mi away"
        
        addArrangedSubview(pointNameLabel)
        addArrangedSubview(distAwayLabel)
    }
    
}
