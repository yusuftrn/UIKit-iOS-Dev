//
//  PlacesVC.swift
//  Locatto
//
//  Created by Yusuf Turan on 18.06.2021.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  
  var placeNameArr = [String]()
  var placeIDArr = [String]()
  var selectedPlaceID = ""
  override func viewDidLoad() {
    super.viewDidLoad()
    getDataFromParse()
    tableView.delegate = self
    tableView.dataSource = self
    
    navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
    navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButton))
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDetailsVC" {
      let destinationVC = segue.destination as! DetailsVC
      destinationVC.chosenPlaceID = selectedPlaceID
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedPlaceID = placeIDArr[indexPath.row]
    self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = placeNameArr[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return placeNameArr.count
  }
  
  func getDataFromParse() {
    let query = PFQuery(className: "Places")
    query.findObjectsInBackground { objects, error in
      if error != nil {
        self.makeAlert("Error", error?.localizedDescription ?? "Error")
      } else {
        if objects != nil {
          self.placeIDArr.removeAll(keepingCapacity: false)
          self.placeNameArr.removeAll(keepingCapacity: false)
          for object in objects! {
            if let placeName = object.object(forKey: "name") as? String {
              if let placeID = object.objectId as? String {
                self.placeNameArr.append(placeName)
                self.placeIDArr.append(placeID)
              }
            }
          }
          self.tableView.reloadData()
        }
      }
    }
  }
  
  @objc func addButton() {
    self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
  }
  
  @objc func logoutButton() {
    PFUser.logOutInBackground { err in
      if err != nil {
        self.makeAlert("Logout Problem", err!.localizedDescription)
      } else {
        self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
      }
    }
  }
  
  func makeAlert(_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okButton)
    present(alert, animated: true, completion: nil)
  }
}
