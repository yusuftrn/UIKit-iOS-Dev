//
//  SecondScreenViewController.swift
//  SegueMultiViewSample
//
//  Created by Yusuf Turan on 11.06.2021.
//

import UIKit

class SecondScreenViewController: UIViewController {
  
  @IBOutlet weak var data: UILabel!
  var dataFromMainScreen: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()
  
    data.text = dataFromMainScreen
    
    let alert = UIAlertController(title: "Sample Alert", message: "Data from main screen: \(dataFromMainScreen)", preferredStyle: UIAlertController.Style.alert)
    let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
    alert.addAction(okButton)
    self.present(alert, animated: true, completion: nil)
  }
  
}
