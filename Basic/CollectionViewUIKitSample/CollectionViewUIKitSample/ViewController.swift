//
//  ViewController.swift
//  CollectionViewUIKitSample
//
//  Created by Yusuf Turan on 24.07.2021.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var movieCollectionView: UICollectionView!
  var movies = [Movie]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    movieCollectionView.delegate = self
    movieCollectionView.dataSource = self
    
    movies.append(Movie(movieTitle: "Django", movieImage: "django", moviePrice: 15.99))
    movies.append(Movie(movieTitle: "Inception", movieImage: "inception", moviePrice: 16.20))
    movies.append(Movie(movieTitle: "Interstellar", movieImage: "interstellar", moviePrice: 10.59))
    movies.append(Movie(movieTitle: "Bir Zamanlar Anadoluda", movieImage: "birzamanlaranadoluda", moviePrice: 22.90))
    movies.append(Movie(movieTitle: "The Hateful Eight", movieImage: "thehatefuleight", moviePrice: 15.99))
    movies.append(Movie(movieTitle: "The Pianist", movieImage: "thepianist", moviePrice: 9.99))
    
    let collectionUI: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    collectionUI.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    collectionUI.minimumLineSpacing = 10
    collectionUI.minimumInteritemSpacing = 10
    
    let colWidth = self.movieCollectionView.frame.size.width
    let cellWidth = (colWidth - 20) / 2
    collectionUI.itemSize = CGSize(width: cellWidth, height: cellWidth*1.94)
    
    movieCollectionView.collectionViewLayout = collectionUI
  }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let movie = movies[indexPath.row]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCellVC

    cell.movienameLabel.text = movie.movieTitle!
    cell.moviepriceLabel.text = "\(movie.moviePrice!) ₺"
    cell.movieImage.image = UIImage(named: movie.movieImage!)
    cell.cellProtocol = self
    cell.indexPath = indexPath
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = movies[indexPath.row]
    print("\(movie.movieTitle!) clicked.")
  }
}

extension ViewController: MovieCellProtocol {
  func addToCart(indexPath: IndexPath) {
    let movie = movies[indexPath.row]
    
    let alert = UIAlertController(title: "Item Purchased", message: "\(movie.movieTitle!) purchased", preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okButton)
    self.present(alert, animated: true, completion: nil)
    
  }
}

