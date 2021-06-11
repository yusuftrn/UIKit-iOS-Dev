//
//  Simpsons.swift
//  SimpsonBook_TableView2
//
//  Created by Yusuf Turan on 12.06.2021.
//

import Foundation
import UIKit

class Simpson {
  var name: String
  var image: UIImage
  var job: String
  
  init(name: String, image: String, job: String) {
    self.name = name
    self.image = UIImage(named: image)!
    self.job = job
  }
}
