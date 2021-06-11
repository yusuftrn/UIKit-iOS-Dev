//
//  ViewController.swift
//  SimpsonBook_TableView2
//
//  Created by Yusuf Turan on 11.06.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var simpsons = [Simpson]()
  var chosenSimpson: Simpson?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    loadStaticData()
     
  }
  
  func loadStaticData() {
    //Objects
    let homer = Simpson(name: "Homer Simpson", image: "homer", job: "Nuclear Safety")
    let marge = Simpson(name: "Marge Simpson", image: "marge", job: "Housewife")
    let bart = Simpson(name: "Bart Simpson", image: "bart", job: "Student")
    let lisa = Simpson(name: "Lisa Simpson", image: "lisa", job: "Student")
    let maggie = Simpson(name: "Maggie Simpson", image: "maggie", job: "Baby")
    simpsons = [homer, marge, bart, lisa, maggie]
    print(simpsons.count)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = simpsons[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return simpsons.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    chosenSimpson = simpsons[indexPath.row]
    self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDetailsVC" {
      let destinationVC = segue.destination as! DetailsViewController
      destinationVC.selectedSimpon = chosenSimpson
    }
  }
  
}

