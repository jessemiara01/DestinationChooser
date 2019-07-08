//
//  RandomPlaceViewController.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 7/2/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import Firebase

class RandomPlaceViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var placeList = [Places]()
    var rand = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generateRandomEntry()
    }
    
    //MARK: - Data Manipulation
    func generateRandomEntry() {
        
        let userRef = (Auth.auth().currentUser?.email)!.replacingOccurrences(of: ".", with: "")
        
        db.collection("\(userRef)").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let name = document.data()["Name"] as! String
                    let address = document.data()["Address"] as! String
                    let placeID = document.data()["PlaceID"] as! String
                    
                    
                    let places = Places()
                    places.placeName = name
                    places.address = address
                    places.placeID = placeID
                    
                    self.placeList.append(places)
                    self.rand = Int.random(in: 0 ..< self.placeList.count)
                    
                    self.nameLabel.text = self.placeList[self.rand].placeName
                    self.addressLabel.text = self.placeList[self.rand].address
                }
            }
        }
    }

    //MARK: - Navigation
    
    @IBAction func RandomButtonPressed(_ sender: UIButton) {
        generateRandomEntry()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        let userRef = (Auth.auth().currentUser?.email)!.replacingOccurrences(of: ".", with: "")
        if rand >= 0{
            let userRef = (Auth.auth().currentUser?.email)!.replacingOccurrences(of: ".", with: "")
            db.collection("\(userRef)").document(placeList[rand].placeID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }

        }
    dismiss(animated: true, completion: nil)
    }
    

}
