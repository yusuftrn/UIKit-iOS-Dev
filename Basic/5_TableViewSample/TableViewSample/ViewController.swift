//
//  ViewController.swift
//  TableViewSample
//
//  Created by Yusuf Turan on 11.06.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var landmarkNames = [String]()
  var landmarks = [UIImage]()
  var chosenLandmarkName: String = ""
  var chosenLandmarkImage = UIImage()
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    importStaticData()
    tableView.delegate = self
    tableView.dataSource = self
    
    navigationItem.title = "LandMarks"
  }
  
  func importStaticData() {
    landmarkNames.append("Colosseum")
    landmarkNames.append("Great Wall")
    landmarkNames.append("Kremlin")
    landmarkNames.append("Stonehenge")
    landmarkNames.append("Taj Mahal")
    
    landmarks.append(UIImage(named: "colosseum")!)
    landmarks.append(UIImage(named: "greatwall")!)
    landmarks.append(UIImage(named: "kremlin")!)
    landmarks.append(UIImage(named: "stonehenge")!)
    landmarks.append(UIImage(named: "tajmahal")!)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = landmarkNames[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return landmarks.count
  }
  
  //when item selected at row
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    chosenLandmarkName = landmarkNames[indexPath.row]
    chosenLandmarkImage = landmarks[indexPath.row]
    performSegue(withIdentifier: "toImageViewController", sender: nil)
  }
  
  //delete item
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      landmarkNames.remove(at: indexPath.row)
      landmarks.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toImageViewController" {
      let destinationVC = segue.destination as! ImageViewController
      destinationVC.selectedLandmarkName = chosenLandmarkName
        destinationVC.selectedLandmarkImage = chosenLandmarkImage
    }
  }
  
}

