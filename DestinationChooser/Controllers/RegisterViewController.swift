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

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .go

    }
    
    // MARK: - Navigation
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        registerUser()
        
    }
    
    //MARK: - Textfield delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField.tag == emailTextField.tag{
            passwordTextField.becomeFirstResponder()
        } else if textField.tag == passwordTextField.tag{
            registerUser()
        }

        return false
    }
    
    
    //MARK: - Authentication
    func registerUser(){
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
