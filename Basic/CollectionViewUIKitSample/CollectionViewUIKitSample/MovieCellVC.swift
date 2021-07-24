//
//  MovieVC.swift
//  CollectionViewUIKitSample
//
//  Created by Yusuf Turan on 24.07.2021.
//

import UIKit

protocol MovieCellProtocol {
  func addToCart(indexPath: IndexPath)
}

class MovieCellVC: UICollectionViewCell {
    
  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var movienameLabel: UILabel!
  @IBOutlet weak var moviepriceLabel: UILabel!
  
  var cellProtocol: MovieCellProtocol?
  var indexPath: IndexPath?
  
  @IBAction func addToCart(_ sender: Any) {
    cellProtocol?.addToCart(indexPath: indexPath!)
  }
}
