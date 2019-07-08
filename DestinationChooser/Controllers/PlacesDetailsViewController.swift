//
//  PlacesDetailsViewController.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 6/30/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import Firebase
import NotificationBannerSwift
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
    //MARK: - Navigaton
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Delete Functionality
    @IBAction func deleteButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "detailsToHome", sender: self)
        removePost()
}
    
    public func removePost() {
        let userRef = (Auth.auth().currentUser?.email)!.replacingOccurrences(of: ".", with: "")
        db.collection("\(userRef)").document(IDToReceive).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
}

}
