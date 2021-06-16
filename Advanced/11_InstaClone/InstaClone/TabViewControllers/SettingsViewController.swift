//
//  SettingsViewController.swift
//  InstaClone
//
//  Created by Yusuf Turan on 14.06.2021.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBAction func logOut(_ sender: Any) {
    do {
      try Auth.auth().signOut()
      self.performSegue(withIdentifier: "toViewController", sender: nil)
    } catch {
      print("Error to Log Out!")
    }
  }
}
