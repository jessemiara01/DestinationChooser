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
        let placesDB = Database.database().reference().child(userRef).child("Places")
        
        placesDB.observe(.childAdded) {(snapshot) in
            let snapshotValue = snapshot.value as! Dictionary <String, String>
            
            let name = snapshotValue["Name"]!
            let address = snapshotValue["Address"]!
            let placeID = snapshotValue["PlaceID"]

            
            let places = Places()
            places.placeName = name
            places.address = address
            places.placeID = placeID ?? "Test"
            
            self.placeList.append(places)
            
            self.rand = Int.random(in: 0 ..< self.placeList.count)

            
            self.nameLabel.text = self.placeList[self.rand].placeName
            self.addressLabel.text = self.placeList[self.rand].address

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
        if rand > 0{
            let placeToRemove = Database.database().reference().child(userRef).child("Places").child(placeList[rand].placeID)
            
            placeToRemove.removeValue()
            generateRandomEntry()
            }
        else{
            print("Couldn't Delete Entry")
        }
    }
    

}
