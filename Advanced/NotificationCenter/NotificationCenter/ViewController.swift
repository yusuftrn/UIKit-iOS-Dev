//
//  ViewController.swift
//  NotificationCenter
//
//  Created by Yusuf Turan on 17.09.2021.
//

import UIKit

extension Notification.Name {
  static let notificationName = Notification.Name("myStream")
}

class ViewController: UIViewController {

  @IBOutlet weak var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.getNotification(notification:)), name: .notificationName, object: nil)
    
  }

  @objc func getNotification(notification: NSNotification) {
    let message = notification.userInfo?["message"] as! String
    let date = notification.userInfo?["date"] as! Date
    let user = notification.userInfo?["object"] as! User
    
    label.text = "\(user.name!) -  \(user.age!) - \(date) - \(message)"
  }

}

