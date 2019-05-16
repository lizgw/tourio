//
//  ProfileViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 1/30/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var myToursStackView: UIStackView!
    
    var username = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for demo, actual username from network
        username = "user\(Int.random(in: 1...100))"
        
        displayInfo()
    }
    
    func displayInfo() {
        // display the username
        usernameLabel.text = username
        
        // get the profile image
        profileImageView.image = UIImage(named: "UserIcon", in: nil, compatibleWith: nil)
    }
    
}
