//
//  Model.swift
//  ArtBook_CoreData
//
//  Created by Yusuf Turan on 12.06.2021.
//

import Foundation

class Art: Identifiable {
  var id: String
  var name: String
  var artist: String
  var year: Int
  var image: Data
  
  init(id: String, name: String, artist: String, year: Int, image: Data) {
    self.id = id
    self.name = name
    self.artist = artist
    self.year = year
    self.image = image
  }
}
