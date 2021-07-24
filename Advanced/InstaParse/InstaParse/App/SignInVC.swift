//
//  SignInVC.swift
//  InstaParse
//
//  Created by Yusuf Turan on 7.07.2021.
//

import UIKit
import Parse

class SignInVC: UIViewController {
  
  @IBOutlet weak var userNameText: UITextField!
  @IBOutlet weak var passwordText: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //check user logged-in before
    let currentUser = PFUser.current()
    if currentUser != nil {
      let board = UIStoryboard(name: "Main", bundle: nil)
      let navigationController = board.instantiateViewController(identifier: "feedView") as! FeedVC
      self.present(navigationController, animated: true, completion: nil)
    }
  }
  
  @IBAction func signIn(_ sender: Any) {
    if userNameText.text != "" && passwordText.text != "" {
      PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { user, err in
        if err != nil {
          self.alert("SignIn Error", err!.localizedDescription)
        } else {
          self.performSegue(withIdentifier: "toTabBar", sender: nil)
        }
      }
    } else {
      self.alert("SignUp Error", "Username or Password is empty.")
    }
  }
  
  @IBAction func signUp(_ sender: Any) {
    if userNameText.text != "" && passwordText.text != "" {
      let user = PFUser()
      user.username = userNameText.text!
      user.password = passwordText.text!
      
      user.signUpInBackground { success, err in
        if err != nil {
          self.alert("SignUp Error", err!.localizedDescription)
        } else {
          self.performSegue(withIdentifier: "toTabBar", sender: nil)
        }
      }
      
    } else {
      self.alert("SignUp Error", "Username or Password is empty.")
    }
  }
  
  public func alert(_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(okButton)
    present(alert, animated: true, completion: nil)
  }

}
