//
//  ViewController.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 6/29/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import Firebase
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
        performSegue(withIdentifier: "toAddNew", sender: self)
    }
    
    @IBAction func showAllPlacesButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toShowAll", sender: self)
    }
    
        
}


