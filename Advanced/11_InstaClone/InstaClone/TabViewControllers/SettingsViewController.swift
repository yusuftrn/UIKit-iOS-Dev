//
//  SettingsViewController.swift
//  InstaClone
//
//  Created by Yusuf Turan on 14.06.2021.
//

import UIKit

class SettingsViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBAction func logOut(_ sender: Any) {
    performSegue(withIdentifier: "toViewController", sender: nil)
  }
  
}
