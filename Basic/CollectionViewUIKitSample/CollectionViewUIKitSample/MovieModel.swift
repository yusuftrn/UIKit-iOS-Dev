//
//  MovieModel.swift
//  CollectionViewUIKitSample
//
//  Created by Yusuf Turan on 24.07.2021.
//

import Foundation

struct Movie {
  var movieID: String?
  var movieTitle: String?
  var movieImage: String?
  var moviePrice: Double?
  
  init() {}
  
  init(movieTitle: String, movieImage: String, moviePrice: Double) {
    self.movieID = UUID().uuidString
    self.movieImage = movieImage
    self.movieTitle = movieTitle
    self.moviePrice = moviePrice
  }
}
