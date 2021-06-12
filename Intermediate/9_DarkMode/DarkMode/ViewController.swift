//
//  ViewController.swift
//  DarkMode
//
//  Created by Yusuf Turan on 12.06.2021.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var button: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    textLabel.textAlignment = NSTextAlignment.left;
    textLabel.numberOfLines = 0;
    textLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
    
    // Decline user's prefer and defer what you want (dark / light)
    overrideUserInterfaceStyle = .light
    
  }
  //  reload active view, every trait change.
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    let userUIStyle = traitCollection.userInterfaceStyle
    if userUIStyle == .dark {
      button.tintColor = UIColor.orange
    } else {
      button.tintColor = UIColor.black
    }
  }

}

