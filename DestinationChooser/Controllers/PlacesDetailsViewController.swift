//
//  PlacesDetailsViewController.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 6/30/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import Firebase

class PlacesDetailsViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var nameToReceive = ""
    var addressToReceive = ""
    var IDToReceive = ""
    
    let reference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = nameToReceive
        addressLabel.text = addressToReceive

    }

    @IBAction func deleteButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "detailsToHome", sender: self)
        removePost()
}
    
    public func removePost() {
        reference.child("Places").child(IDToReceive).removeValue()
}

}
