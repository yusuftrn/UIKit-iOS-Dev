//
//  ViewController.swift
//  Locatto
//
//  Created by Yusuf Turan on 18.06.2021.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
  @IBOutlet weak var userNameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  @IBAction func signInClicked(_ sender: Any) {
    if userNameField.text != "" && passwordField.text != "" {
      PFUser.logInWithUsername(inBackground: userNameField.text!, password: passwordField.text!) { user, err in
        if err != nil {
          self.makeAlert("SignIn Error", err!.localizedDescription)
        } else {
          if user != nil {
            self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
            //print(user.username!)
          }
        }
      }
    } else {
      makeAlert("Error", "Username or Password is empty.")
    }
  }
  
  @IBAction func signUpClicked(_ sender: Any) {
    if userNameField.text != "" && passwordField.text != "" {
      let user = PFUser()
      user.username = userNameField.text!
      user.password = passwordField.text!
      user.signUpInBackground { success, err in
        if err != nil {
          self.makeAlert("SignUp Error", err!.localizedDescription)
        } else {
          //segue
          self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
          print("User account created.")
        }
      }
    } else {
      makeAlert("Error", "Username or Password is empty.")
    }
  }
  
  func makeAlert(_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okButton)
    present(alert, animated: true, completion: nil)
  }
}
