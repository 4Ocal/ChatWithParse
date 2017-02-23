//
//  ViewController.swift
//  ChatWithParse
//
//  Created by Calvin Chu on 2/20/17.
//  Copyright © 2017 Calvin Chu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                self.showAlert(errorMsg: error.localizedDescription)
            } else {
                // Hooray! Let them use the app now.
                self.loginSegue()
            }
            
        }
    }
    
    @IBAction func login(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (succedded: PFUser?, error: Error?) -> Void in
            if let error = error {
                self.showAlert(errorMsg: error.localizedDescription)
            } else {
                // Hooray! Let them use the app now.
                self.loginSegue()
            }
        }
    }
    
    func showAlert(errorMsg: String) {
        let alertController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        // create a cancel action
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }

    }
    
    func loginSegue() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavigationController")
        self.present(vc, animated: true, completion: nil)
    }


}

