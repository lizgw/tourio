//
//  TourListing.swift
//  Tourio_v1
//
//  Created by Wigglesworth, Elizabeth G on 10/29/18.
//  Copyright © 2018 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

protocol TourListingViewProtocol {
    func tourListingViewTapped(tour: Tour)
}

@IBDesignable class TourListingView : UIStackView {
    
    var tour: Tour
    
    var delegate: TourListingViewProtocol!
    
    var tourIcon : UIImageView!
    var textStackView : UIStackView!
    var nameLabel : UILabel!
    var detailsLabel : UILabel!
    var tapRecognizer : UITapGestureRecognizer!
    
    // MARK: initialization
    init(tour: Tour) {
        self.tour = tour
        super.init(frame: CGRect.zero)
        setupElements()
    }
    
    // figure out how to actually use a parameter here?
    required init(coder: NSCoder) {
        self.tour = Tour(createdBy: "DEFAULT", isOrdered: true)
        super.init(coder: coder)
        setupElements()
    }
    
    // MARK: private methods
    private func setupElements() {
        
        // setup main stack view
        spacing = 4
        
        // create icon image
        tourIcon = UIImageView()
        tourIcon.image = UIImage(named: tour.iconPath, in: nil, compatibleWith: nil) // TODO: use actual image
        
        // add constraints
        // disable auto constraints
        tourIcon.translatesAutoresizingMaskIntoConstraints = false
        // 100x100 h & w constraints
        tourIcon.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        tourIcon.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        // add image to stack view
        addArrangedSubview(tourIcon)
        
        // add the horizontal stack view
        textStackView = UIStackView()
        textStackView.axis = .vertical
        addArrangedSubview(textStackView) // add to main view
        
        // add the tour title text
        nameLabel = UILabel()
        nameLabel.text = tour.name
        nameLabel.font = nameLabel.font.withSize(20.0)
        textStackView.addArrangedSubview(nameLabel) // add to stack view
        
        // add the tour details (user & distance)
        detailsLabel = UILabel()
        detailsLabel.text = "by \(tour.createdBy) - \(tour.distanceAway) mi away"
        detailsLabel.font = detailsLabel.font.withSize(12.0)
        textStackView.addArrangedSubview(detailsLabel) // add to stack view
        
        // add the tap gesture recognizer
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tourTapped(_:)))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tourTapped(_ sender : UITapGestureRecognizer) {
        // let the view controller deal with it
        delegate.tourListingViewTapped(tour: tour)
    }
    
}
