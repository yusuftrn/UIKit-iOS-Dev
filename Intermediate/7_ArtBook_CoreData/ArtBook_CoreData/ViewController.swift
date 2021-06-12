//
//  ViewController.swift
//  ArtBook_CoreData
//
//  Created by Yusuf Turan on 12.06.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  var arts = [Art]()
  var selectedPainting: Art?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    // MARK: Navigation button (+)
    navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
    
    getData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
  }

  @objc func addButtonClicked() {
    selectedPainting = nil
    performSegue(withIdentifier: "toDetailsVC", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = arts[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedPainting = arts[indexPath.row]
    performSegue(withIdentifier: "toDetailsVC", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDetailsVC" {
      let destinationVC = segue.destination as! DetailsViewController
      destinationVC.chosenPainting = selectedPainting
    }
  }
  
  @objc func getData() {
    arts.removeAll(keepingCapacity: false)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Painting")
    fetchRequest.returnsObjectsAsFaults = false
    do {
      let results = try context.fetch(fetchRequest)
      for result in results as! [NSManagedObject] {
        guard let id = result.value(forKey: "id") as? String else {
          return
        }
        guard let name = result.value(forKey: "name") as? String else {
          return
        }
        guard let artist = result.value(forKey: "artist") as? String else {
          return
        }
        guard let year = result.value(forKey: "year") as? Int else {
          return
        }
        guard let image = result.value(forKey: "image") as? Data else {
          return
        }
        arts.append(Art(id: id, name: name, artist: artist, year: year, image: image))
        self.tableView.reloadData()
      }
    } catch {
      print("Can't fetch data!")
    }
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let context = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Painting")
      let idString = arts[indexPath.row].id
      fetchRequest.predicate = NSPredicate(format: "id == %@", idString)
      fetchRequest.returnsObjectsAsFaults = false
      do {
        let results = try context.fetch(fetchRequest)
        if results.count > 0 {
          for result in results as! [NSManagedObject] {
            if let id = result.value(forKey: "id") as? String {
              if id == arts[indexPath.row].id {
                context.delete(result)
                arts.remove(at: indexPath.row)
                print("Deleted :\(id)")
                self.tableView.reloadData()
                do {
                  try context.save()
                } catch {
                  print("Error on Delete")
                }
              }
            }
          }
        }
      } catch {
        print("Error on Delete")
      }
    }
  }
}

