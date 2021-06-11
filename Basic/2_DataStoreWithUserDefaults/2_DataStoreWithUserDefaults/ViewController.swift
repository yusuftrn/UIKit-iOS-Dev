//
//  ViewController.swift
//  2_DataStoreWithUserDefaults
//
//  Created by Yusuf Turan on 11.06.2021.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var userName: UITextField!
  @IBOutlet weak var userMail: UITextField!
  @IBOutlet weak var collegeName: UITextField!
  @IBOutlet weak var anotherData: UITextField!
  
  @IBOutlet weak var result: UILabel!
  
  let defaultSaveLoad = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    result.textAlignment = NSTextAlignment.center
    result.numberOfLines = 0
    result.font = UIFont.systemFont(ofSize: 16)
    
    guard let name = defaultSaveLoad.object(forKey: "name") else {
      return
    }
    guard let email = defaultSaveLoad.object(forKey: "email") else {
      return
    }
    guard let college = defaultSaveLoad.object(forKey: "college") else {
      return
    }
    
    guard let sample = defaultSaveLoad.object(forKey: "sample") else {
      return
    }
    
    var resultData = ""
    resultData.append("User: \(name)\n")
    resultData.append("Email: \(email)\n")
    resultData.append("College: \(college)\n")
    resultData.append("Sample Data: \(sample)\n")
    
    if resultData != "" {
      self.result.text = resultData
    }
    
  }

  @IBAction func saveData(_ sender: Any) {
    
    let userName: String = userName.text!
    let userMail: String = userMail.text!
    let userCollege: String = collegeName.text!
    let sampleData: String = anotherData.text!
    
    defaultSaveLoad.set(userName, forKey: "name")
    defaultSaveLoad.set(userMail, forKey: "email")
    defaultSaveLoad.set(userCollege, forKey: "college")
    defaultSaveLoad.set(sampleData, forKey: "sample")
    
    var resultData = ""
    resultData.append("User: \(userName)\n")
    resultData.append("Email: \(userMail)\n")
    resultData.append("College: \(userCollege)\n")
    resultData.append("Sample Data: \(sampleData)\n")
    
    if resultData != "" {
      self.result.text = resultData
    }
  }
  
  @IBAction func deleteData(_ sender: Any) {
    defaultSaveLoad.removeObject(forKey: "name")
    defaultSaveLoad.removeObject(forKey: "email")
    defaultSaveLoad.removeObject(forKey: "college")
    defaultSaveLoad.removeObject(forKey: "sample")
    userName.text = ""
    userMail.text = ""
    collegeName.text = ""
    anotherData.text = ""
  }
}

