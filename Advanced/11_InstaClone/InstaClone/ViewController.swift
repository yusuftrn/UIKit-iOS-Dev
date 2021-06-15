//
//  ViewController.swift
//  InstaClone
//
//  Created by Yusuf Turan on 14.06.2021.
//

import UIKit
import Firebase
class ViewController: UIViewController {
  
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func signIn(_ sender: Any) {
    if emailField.text != nil && passwordField.text != nil {
      Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (authData, err) in
        if err != nil {
          self.sendAlert(title: "ERROR", message: err?.localizedDescription ?? "ERROR??")
        } else {
          self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
      }
    } else {
      self.sendAlert(title: "ERROR", message: "There is something error with username/password.")
    }
  }
  
  @IBAction func signUp(_ sender: Any) {
    if emailField.text != nil && passwordField.text != nil {
      Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (authData, err) in
        if err != nil {
          self.sendAlert(title: "ERROR", message: err?.localizedDescription ?? "ERROR??")
        } else {
          self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
      }
    } else {
      self.sendAlert(title: "ERROR", message: "There is something error with username/password.")
    }
  }
  
  func sendAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okButton)
    self.present(alert, animated: true, completion: nil)
  }
}

