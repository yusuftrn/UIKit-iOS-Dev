//
//  ImageViewController.swift
//  TableViewSample
//
//  Created by Yusuf Turan on 11.06.2021.
//

import UIKit

class ImageViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var landmarkLabel: UILabel!
  
  var selectedLandmarkName = ""
  var selectedLandmarkImage = UIImage()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    landmarkLabel.text = selectedLandmarkName
    imageView.image = selectedLandmarkImage
    
  }
  
}
