//
//  ViewController.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 6/29/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import Firebase
import GooglePlaces

var test : String = "Nothing passed"
class HomePageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Override point for customization after application launch.
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    @IBAction func addNewPlaceButtonPressed(_ sender: Any) {
        startMapModule()
    }
    
    @IBAction func showAllPlacesButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toShowAll", sender: self)
    }
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "backToLogin", sender: self)
        }
        catch{
            print("Could not sign out.")
        }
    }
    
    
    
    // Present the Autocomplete view controller when the button is pressed.
    @objc func startMapModule() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.formattedAddress.rawValue) | UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: false, completion: nil)
    }
    
        
}


extension HomePageViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let userRef = (Auth.auth().currentUser?.email)!.replacingOccurrences(of: ".", with: "")
        let POIName = (place.name ?? "N/A")
        let POIAddress = (place.formattedAddress ?? "N/A")
        let PlaceID = place.placeID ?? "N/A"
        
        dismiss(animated: false, completion: nil)
        
        let placesDB = Database.database().reference().child(userRef).child("Places")
        let placesDictionary = ["Name" : POIName,
                                "Address" : POIAddress,
                                "PlaceID" : PlaceID]
        
        
        placesDB.child(PlaceID).setValue(placesDictionary) {
            (error, reference) in
            
            if error != nil{
                print(error!)
            }
            else {
                print("Successfully added to DB")
            }
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: false, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}



