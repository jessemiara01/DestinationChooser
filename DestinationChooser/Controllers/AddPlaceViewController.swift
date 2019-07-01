//
//  AddPlaceViewController.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 6/29/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import GooglePlaces
import Firebase

class AddPlaceViewController: UIViewController {
    

    
    override func viewDidLoad() {
        startMapModule()
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
        present(autocompleteController, animated: true, completion: nil)
    }
    

    
}

extension AddPlaceViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let POIName = (place.name ?? "N/A")
        let POIAddress = (place.formattedAddress ?? "N/A")
        let PlaceID = place.placeID ?? "N/A"
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "homeAfterAdd", sender: self)
        
        let placesDB = Database.database().reference().child("Places")
        
        
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
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
