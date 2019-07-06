//
//  Constants.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 7/5/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import Foundation
import Firebase


let userRef = (Auth.auth().currentUser?.email)!.replacingOccurrences(of: ".", with: "")

let googleAPIKey : String = "AIzaSyDmUvzkBmM44YLB9qqrBrniO701r0fh6hI"
