//
//  ViewController.swift
//  1_HelloImageChanger
//
//  Created by Yusuf Turan on 11.06.2021.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func changeImage(_ sender: Any) {
    imageView.image = UIImage.init(named: "algorithm")
  }
  
}

