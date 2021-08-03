//
//  ViewController.swift
//  UserDefaultsSample
//
//  Created by Yusuf Turan on 25.07.2021.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let data = UserDefaults.standard
    
    data.set("Yusuf", forKey: "name")
    data.set(18, forKey: "age")
    data.set(173.42, forKey: "height")
    data.set(false, forKey: "ismarried")
    
    let friends = ["Ahmet", "Murat", "Mete"]
    data.set(friends, forKey: "friends")
    
    //Read Data:
    let name = data.string(forKey: "name") ?? "UNDEFINED"
    let age = data.integer(forKey: "age")
    let height = data.double(forKey: "height")
    let isMarried = data.bool(forKey: "ismarried")
    
    print("\(name) \(age) \(height) \(isMarried) and his friend \(data.array(forKey: "friends")![1]) is stupid.")
    
    //Remove an object
    data.removeObject(forKey: "age")
    
    //Update an object
    data.set("Ahmet", forKey: "name")
  }


}

