//
//  ViewController.swift
//  SegueMultiViewSample
//
//  Created by Yusuf Turan on 11.06.2021.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var dataText: UITextField!
  @IBOutlet weak var timerText: UILabel!
  @IBOutlet weak var sendButton: UIButton!
  var localData: String = ""
  var timer = Timer()
  var counter = 5
  
  override func viewDidLoad() {
    super.viewDidLoad()
    counter = 5
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
  }
  
  @objc func timerFunction() {
    timerText.text = "wait for \(counter) second to button activated"
    counter -= 1
    if counter == 0 {
      timer.invalidate()
      timerText.text = "Button is active"
    }
    
    if counter > 0 {
      self.sendButton.isEnabled = false
    } else {
      self.sendButton.isEnabled = true
    }
  }

  @IBAction func sendData(_ sender: Any) {
    localData = dataText.text!
    performSegue(withIdentifier: "toSecondVC", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toSecondVC" {
      let destinationVC = segue.destination as! SecondScreenViewController
      destinationVC.dataFromMainScreen = self.localData
    }
  }
}

