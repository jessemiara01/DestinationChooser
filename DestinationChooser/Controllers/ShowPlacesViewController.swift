//
//  ShowPlacesViewController.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 6/29/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import Firebase

class ShowPlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    
    let cellReuseIdentifier  = "cell"
    var currentRow = 0
    var placeList = [Places]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
        retreiveMessages()
        
    }
    
    func retreiveMessages() {
        let userRef = (Auth.auth().currentUser?.email)!.replacingOccurrences(of: ".", with: "")
        let placesDB = Database.database().reference().child(userRef).child("Places")
        
        placesDB.observe(.childAdded) {(snapshot) in
            let snapshotValue = snapshot.value as! Dictionary <String, String>
            
            let name = snapshotValue["Name"]!
            let address = snapshotValue["Address"]!
            let placeID = snapshotValue["PlaceID"]
            print(name,address,placeID!)
            
            let places = Places()
            places.placeName = name
            places.address = address
            places.placeID = placeID ?? "Test"
            
            self.placeList.append(places)
            self.tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        }
        
        // set the text from the data model
        let customColor = UIColor(red: 52, green: 69, blue: 158, alpha: 0)
        cell.backgroundColor = customColor
        cell?.textLabel?.text = placeList[indexPath.row].placeName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
       performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails"{
            
            let destinationVC = segue.destination as! PlacesDetailsViewController
            destinationVC.nameToReceive = placeList[currentRow].placeName
            destinationVC.addressToReceive = placeList[currentRow].address
            destinationVC.IDToReceive = placeList[currentRow].placeID
            
            
            
        }
    }
}
