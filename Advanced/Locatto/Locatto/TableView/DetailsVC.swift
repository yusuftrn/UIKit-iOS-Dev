//
//  DetailsVC.swift
//  Locatto
//
//  Created by Yusuf Turan on 23.06.2021.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {
  @IBOutlet weak var detailsImageView: UIImageView!
  @IBOutlet weak var detailsNameLabel: UILabel!
  @IBOutlet weak var detailsTypeLabel: UILabel!
  @IBOutlet weak var detailsAthmosLabel: UILabel!
  @IBOutlet weak var detailsMapView: MKMapView!
  
  var chosenPlaceID = ""
  var chosenLatidue = Double()
  var chosenLongitude = Double()
  
  override func viewDidLoad() {
    getDataFromParse()
  }
  
  private func getDataFromParse() {
    let query = PFQuery(className: "Places")
    query.whereKey("objectId", equalTo: chosenPlaceID)
    query.findObjectsInBackground { (objects, error) in
      if error != nil {
        
      } else {
        if objects != nil {
          if objects!.count > 0 {
            let object = objects![0]
            if let placeName = object.object(forKey: "name") as? String {
              self.detailsNameLabel.text = placeName
            }
            if let placeType = object.object(forKey: "type") as? String {
              self.detailsTypeLabel.text = placeType
            }
            if let placeAthmos = object.object(forKey: "atmosphere") as? String {
              self.detailsAthmosLabel.text = placeAthmos
            }
            if let placeLatitude = object.object(forKey: "latitde") as? String {
              if let placeLatitudeDouble = Double(placeLatitude) {
                self.chosenLatidue = placeLatitudeDouble
              }
            }
            if let placeLongitude = object.object(forKey: "longitude") as? String {
              if let placeLongitudeDouble = Double(placeLongitude) {
                self.chosenLongitude = placeLongitudeDouble
              }
            }
            if let imageData = object.object(forKey: "image") as? PFFileObject {
              imageData.getDataInBackground { data, error in
                if error == nil {
                  self.detailsImageView.image = UIImage(data: data!)
                }
              }
            }
            let location = CLLocationCoordinate2D(latitude: self.chosenLatidue, longitude: self.chosenLongitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
            let region = MKCoordinateRegion(center: location, span: span)
            self.detailsMapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = self.detailsNameLabel.text!
            annotation.subtitle = self.detailsTypeLabel.text!
            self.detailsMapView.addAnnotation(annotation)
          }
        }
      }
    }
  }
}
