//
//  ViewController.swift
//  URLSessions
//
//  Created by Yusuf Turan on 19.09.2021.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //addPerson(user: "Yusuf", phone: "555")
    //deletePerson(id: "2587")
    //updateUser(id: "2666", name: "Mehmet", phone: "4444")
    getAllData()
    //getUserData(user: "Yusuf")
  }
  
  func addPerson(user userName: String, phone phoneNumber: String) {
    var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php")!)
    request.httpMethod = "POST"
    let postString = "kisi_ad=\(userName)&kisi_tel=\(phoneNumber)"
    request.httpBody = postString.data(using: .utf8)
    URLSession.shared.dataTask(with: request) { (data, response, err) in
      if err != nil || data == nil {
        print("Error fetching data")
        return
      }
      do {
        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
          print(json)
        }
      } catch {
        print(err!.localizedDescription)
      }
    }.resume()
  }
  
  func deletePerson(id userID: String) {
    var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php")!)
    request.httpMethod = "POST"
    let postString = "kisi_id=\(userID)"
    request.httpBody = postString.data(using: .utf8)
    URLSession.shared.dataTask(with: request) { (data, response, err) in
      if err != nil || data == nil {
        print("Error deleting user")
        return
      }
      do {
        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
          print(json)
        }
      } catch {
        print(err!.localizedDescription)
      }
      
    }.resume()
  }
  
  func updateUser(id userID: String, name userName: String, phone phoneNumber: String) {
    var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/update_kisiler.php")!)
    request.httpMethod = "POST"
    let postString = "kisi_id=\(userID)&kisi_ad=\(userName)&kisi_tel=\(phoneNumber)"
    request.httpBody = postString.data(using: .utf8)
    URLSession.shared.dataTask(with: request) { (data, response, err) in
      if err != nil || data == nil {
        print("Error updating data.")
        return
      }
      do {
        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
          print(json)
        }
      } catch {
        print(err!.localizedDescription)
      }
    }.resume()
  }
  
  func getAllData() {
    let url = URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php")!
    URLSession.shared.dataTask(with: url) { data,response,err in
      if err != nil || data == nil {
        print("Error fetching data")
        return
      }
      do {
        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
          if let users = json["kisiler"] as? [[String: Any]] {
            for user in users {
              print("User ID: \(user["kisi_id"]!)")
              print("User Name: \(user["kisi_ad"]!)")
              print("User Number: \(user["kisi_tel"]!)")
              print("-------------------")
            }
          }
        }
      } catch {
        print(err!.localizedDescription)
      }
    }.resume()
  }
  
  func getUserData(user: String) {
    var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php")!)
    request.httpMethod = "POST"
    let postString = "kisi_ad=\(user)"
    request.httpBody = postString.data(using: .utf8)
    URLSession.shared.dataTask(with: request) { data,response,err in
      if err != nil || data == nil {
        print("Error fetching data")
        return
      }
      do {
        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
          print(json)
        }
      } catch {
        print(err!.localizedDescription)
      }
    }.resume()
  }
  
}

