//
//  ViewController.swift
//  CurrencyJSON
//
//  Created by Yusuf Turan on 12.06.2021.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var cadLabel: UILabel!
  @IBOutlet weak var chfLabel: UILabel!
  @IBOutlet weak var gbpLabel: UILabel!
  @IBOutlet weak var jpyLabel: UILabel!
  @IBOutlet weak var usdLabel: UILabel!
  @IBOutlet weak var tryLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func getRates(_ sender: Any) {
    // 1) Request & Session
    let url = URL(string: "http://data.fixer.io/api/latest?access_key=902f07c548de3b6bae07ad0704c9b64b&format=1")
    let session = URLSession.shared
    session.dataTask(with: url!) { (data, response, err) in
      if err != nil {
        let alert = UIAlertController(title: "ERROR", message: err?.localizedDescription, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
      } else {
        // 2) Response & Data
        if data != nil {
          let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? Dictionary<String, Any>
          DispatchQueue.main.async {
            //3 : JSON & Serialization
            if let rates = jsonResponse!["rates"] as? [String: Any] {
              if let cad = rates["CAD"] as? Double {
                self.cadLabel.text = "CAD: \(cad)"
              }
              if let chf = rates["CHF"] as? Double {
                self.chfLabel.text = "CHF: \(chf)"
              }
              if let gbp = rates["GBP"] as? Double {
                self.gbpLabel.text = "GBP: \(gbp)"
              }
              if let jpy = rates["JPY"] as? Double {
                self.jpyLabel.text = "JPY: \(jpy)"
              }
              if let usd = rates["USD"] as? Double {
                self.usdLabel.text = "USD: \(usd)"
              }
              if let turkish = rates["TRY"] as? Double {
                self.tryLabel.text = "TRY: \(turkish)"
              }
            }
          }
        }
      }
    }.resume()
  }
  
}

