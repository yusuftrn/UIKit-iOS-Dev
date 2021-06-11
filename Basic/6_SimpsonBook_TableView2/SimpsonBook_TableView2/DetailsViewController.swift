//
//  DetailsViewController.swift
//  SimpsonBook_TableView2
//
//  Created by Yusuf Turan on 11.06.2021.
//

import UIKit

class DetailsViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var jobLabel: UILabel!
  
  var selectedSimpon: Simpson?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameLabel.text = selectedSimpon?.name
    imageView.image = selectedSimpon?.image
    jobLabel.text = selectedSimpon?.job
  }
}
