//
//  Model.swift
//  AdressMaps
//
//  Created by Yusuf Turan on 12.06.2021.
//

import Foundation

class PlaceModel: Identifiable {
  var id: String
  var title: String
  var subtitle: String
  var latitude: Double
  var longitude: Double
  
  init(id: String, title: String, subtitle: String, latitude: Double, longitude: Double) {
    self.id = id
    self.title = title
    self.subtitle = subtitle
    self.latitude = latitude
    self.longitude = longitude
  }
}
