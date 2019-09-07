//
//  AppDelegate.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 6/29/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import Firebase
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    override init(){
        FirebaseApp.configure()
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        GMSPlacesClient.provideAPIKey(googleAPIKey)
        return true
    }
    
}

