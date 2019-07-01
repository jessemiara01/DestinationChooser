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

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func deleteButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "detailsToHome", sender: self)
        removePost()

        

    }
    
    public func removePost() {
        reference.child("Places").child(IDToReceive).removeValue()

        
        
        
        

    
    }

}
