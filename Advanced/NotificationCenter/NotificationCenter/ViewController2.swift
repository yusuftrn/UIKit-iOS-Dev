//
//  ViewController2.swift
//  NotificationCenter
//
//  Created by Yusuf Turan on 17.09.2021.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  @IBAction func sendNotification(_ sender: Any) {
    
    let user = User(userName: "Ahmet", userAge: "18")
    
    NotificationCenter.default.post(
      name: .notificationName,
      object: nil,
      userInfo: ["message": "Hey", "date": Date(), "object": user]
    )
    dismiss(animated: true, completion: nil)
  }
  
}
