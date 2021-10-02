//
//  Users.swift
//  NotificationCenter
//
//  Created by Yusuf Turan on 17.09.2021.
//

import Foundation

class User {
  var name: String?
  var age: String?
  
  init() {
    
  }
  
  init(userName: String, userAge: String) {
    self.age = userAge
    self.name = userName
  }
}
