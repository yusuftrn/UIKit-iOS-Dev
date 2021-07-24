//
//  MapVC.swift
//  Locatto
//
//  Created by Yusuf Turan on 23.06.2021.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  var locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonClicked))
    navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClicked))
    
    mapView.delegate = self
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
    recognizer.minimumPressDuration = 2
    mapView.addGestureRecognizer(recognizer)
  }
  
  @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer) {
    if gestureRecognizer.state == UIGestureRecognizer.State.began {
      let touches = gestureRecognizer.location(in: self.mapView)
      let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
      
      let annotation = MKPointAnnotation()
      annotation.coordinate = coordinates
      annotation.title = PlaceData.sharedInstance.placeName
      annotation.subtitle = PlaceData.sharedInstance.placeType
      
      self.mapView.addAnnotation(annotation)
      
      PlaceData.sharedInstance.placeLatitude = String(coordinates.latitude)
      PlaceData.sharedInstance.placeLongitude = String(coordinates.longitude)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //locationManager.stopUpdatingLocation()
    let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    let region = MKCoordinateRegion(center: location, span: span)
    mapView.setRegion(region, animated: true)
  }
  
  @objc func saveButtonClicked() {
    let place = PlaceData.sharedInstance
    let object = PFObject(className: "Places")
    object["name"] = place.placeName
    object["type"] = place.placeType
    object["atmosphere"] = place.placeAthmos
    object["latitude"] = place.placeLatitude
    object["longitude"] = place.placeLongitude
    
    if let imageData = place.placeImage.jpegData(compressionQuality: 0.5) {
      object["image"] = PFFileObject(name: "image.jpg", data: imageData)
    }
    object.saveInBackground { success, error in
      if error != nil {
        let error = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        error.addAction(okButton)
        self.present(error, animated: true, completion: nil)
      } else {
        self.performSegue(withIdentifier: "fromMapVCtoTableVC", sender: nil)
      }
    }
  }
  
  @objc func cancelButtonClicked() {
    self.dismiss(animated: true, completion: nil)
  }
  
}
