//
//  ViewController.swift
//  Parse Chat
//
//  Created by Anthony Lee on 10/9/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signUp(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        if (usernameTextfield.text?.isEmpty)! || (passwordTextfield.text?.isEmpty)! {
            let alert = UIAlertController(title: "Empty Username and Password", message: "Please type in your username and password", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert,animated: true)
            return
        }
        // set user properties
        newUser.username = usernameTextfield.text
        newUser.password = passwordTextfield.text
        
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                let alert = UIAlertController(title: "Error", message: "There was an error in signing up. Please try again", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert,animated: true)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let username = usernameTextfield.text ?? ""
        let password = passwordTextfield.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                let alert = UIAlertController(title: "Error", message: "There was an error in logging up. Please try again", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert,animated: true)
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)

            }
        }
    }
    
}

