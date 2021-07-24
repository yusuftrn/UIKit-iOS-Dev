//
//  PlaceData.swift
//  Locatto
//
//  Created by Yusuf Turan on 24.06.2021.
//

import Foundation
import UIKit

class PlaceData {
  static let sharedInstance = PlaceData()
  
  var placeName = ""
  var placeType = ""
  var placeAthmos = ""
  var placeImage = UIImage()
  var placeLatitude = ""
  var placeLongitude = ""
  private init() {}
}
