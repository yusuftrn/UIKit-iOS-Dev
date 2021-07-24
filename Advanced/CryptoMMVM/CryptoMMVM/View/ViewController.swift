//
//  ViewController.swift
//  CryptoMMVM
//
//  Created by Yusuf Turan on 7.07.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  private var cryptoListVM: CryptoListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    getData()
  }
  
  func getData() {
    let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
    Webservice().downloadData(url: url) { cryptoList in
      if let cryptoList = cryptoList {
        self.cryptoListVM = CryptoListViewModel(currenyList: cryptoList)
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cryptoListVM == nil ? 0 : self.cryptoListVM.numberOfRowsInSection()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cryptoCell", for: indexPath) as! CryptoViewCellTableViewCell
    let cryptoVM = self.cryptoListVM.cryptoAtIndex(indexPath.row)
    cell.cryptoName.text = cryptoVM.name
    cell.cryptoPrice.text = cryptoVM.price
    return cell
  }
}

