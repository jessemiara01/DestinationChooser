//
//  ShowPlacesViewController.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 6/29/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import Firebase
import SwipeCellKit
class ShowPlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    
    let cellReuseIdentifier  = "cell"
    var currentRow = 0
    var placeList = [Places]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        retreiveMessages()
    }
   
    
    //MARK: - Firestore Methods
    func retreiveMessages() {
        
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
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - TableView Methods
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let userRef = (Auth.auth().currentUser?.email)!.replacingOccurrences(of: ".", with: "")
            db.collection("\(userRef)").document(placeList[indexPath.row].placeID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    self.placeList.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .bottom)
                }
            }
            
        }
    }
    
    //MARK: - Navigation 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails"{
            
            let destinationVC = segue.destination as! PlacesDetailsViewController
            destinationVC.nameToReceive = placeList[currentRow].placeName
            destinationVC.addressToReceive = placeList[currentRow].address
            destinationVC.IDToReceive = placeList[currentRow].placeID
            
            
            
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

