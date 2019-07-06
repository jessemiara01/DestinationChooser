//
//  RegisterViewController.swift
//  DestinationChooser
//
//  Created by Jesse Miara on 7/1/19.
//  Copyright © 2019 Jesse Miara. All rights reserved.
//

import UIKit
import Firebase
import NotificationBannerSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Navigation
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            if error != nil {
                print(error!)
                let banner = NotificationBanner(title: "Could Not Register",subtitle: "Please try again", style: .danger)
                banner.show()
            }
            else{
                print("User Registered")
                self.performSegue(withIdentifier: "afterRegister", sender: self)
            }
        }
        
    }



}
