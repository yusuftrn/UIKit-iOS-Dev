//
//  ListViewController.swift
//  AdressMaps
//
//  Created by Yusuf Turan on 12.06.2021.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var places = [PlaceModel]()
  var selectedPlace: PlaceModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    getData()
    navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil)
  }
  
  @objc func getData() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
    request.returnsObjectsAsFaults = false
    
    do {
      let results = try context.fetch(request)
      if results.count > 0 {
        self.places.removeAll(keepingCapacity: false)
        for result in results as! [NSManagedObject] {
          guard let id = result.value(forKey: "id") as? String else {
            return
          }
          guard let title = result.value(forKey: "title") as? String else {
            return
          }
          guard let subtitle = result.value(forKey: "subtitle") as? String else {
            return
          }
          guard let latitude = result.value(forKey: "latitude") as? Double else {
            return
          }
          guard let longitude = result.value(forKey: "longitude") as? Double else {
            return
          }
          let placeCell = PlaceModel(id: id, title: title, subtitle: subtitle, latitude: latitude, longitude: longitude)
          places.append(placeCell)
          tableView.reloadData()
        }
      }
    } catch {
      print("Error!")
    }
  }
  
  @objc func addButton() {
    selectedPlace = nil
    performSegue(withIdentifier: "toMapVC", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return places.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = places[indexPath.row].title
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedPlace = places[indexPath.row]
    performSegue(withIdentifier: "toMapVC", sender: nil)
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toMapVC" {
      let destinationVC = segue.destination as! ViewController
      destinationVC.choosenPlace = selectedPlace
    }
  }
}
