//
//  CreateTourViewController.swift
//  Tourio
//
//  Created by Wigglesworth, Elizabeth G on 2/5/19.
//  Copyright © 2019 Wigglesworth, Elizabeth G. All rights reserved.
//

import UIKit
import Firebase

class CreateTourViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var orderedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameField.layer.borderColor = UIColor.lightGray.cgColor
        nameField.layer.borderWidth = 1
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        descriptionField.layer.borderWidth = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 3
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "TourCreated" {
            if nameField.text! == "" {
                return false
            }
        }

        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        
        guard let destination = segue.destination as? TourDetailsViewController,
            nameField.text! != "" else {
            return
        }
        
        let tour = Tour(createdBy: "Ryan", isOrdered: orderedSwitch.isOn)
        tour.name = nameField.text!
        tour.desc = descriptionField.text
        tour.isOrdered = orderedSwitch.isOn
        
        let db = Firestore.firestore()
        
        var ref : DocumentReference? = nil
        
        ref = db.collection("testTours").document(tour.name)
        
        ref!.setData([
            "name": nameField.text!,
            "desc": descriptionField.text,
            "createdBy": "Ryan",
            "iconPath": "",
            "isOrdered": orderedSwitch.isOn
            ])
        
        ref?.collection("points").addDocument(data: ["Name": "Point A"])
        
        destination.tour = tour
    }

}
