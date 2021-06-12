//
//  ViewController.swift
//  AdressMaps
//
//  Created by Yusuf Turan on 12.06.2021.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

  @IBOutlet weak var nameText: UITextField!
  @IBOutlet weak var commentText: UITextField!
  @IBOutlet weak var mapView: MKMapView!
  var localLatitude: Double = 0.0
  var localLongitude: Double = 0.0
  var place: PlaceModel?
  var choosenPlace: PlaceModel?
  
  var locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    
    let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer: )))
    gestureRecognizer.minimumPressDuration = 3
    mapView.addGestureRecognizer(gestureRecognizer)
    
    if let chosen = choosenPlace {
      nameText.text = chosen.title
      nameText.isEnabled = false
      commentText.text = chosen.subtitle
      commentText.isEnabled = false
      
      let annotation = MKPointAnnotation()
      annotation.title = chosen.title
      annotation.subtitle = chosen.subtitle
      
      let coordinate = CLLocationCoordinate2D(latitude: chosen.latitude, longitude: chosen.longitude)
      annotation.coordinate = coordinate
      mapView.addAnnotation(annotation)
      //stop auto updating
      locationManager.stopUpdatingLocation()
      
      let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
      let region = MKCoordinateRegion(center: coordinate, span: span)
      mapView.setRegion(region, animated: true)
      
    } else {
      locationManager.startUpdatingLocation()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: location, span: span)
    mapView.setRegion(region, animated: true)
  }
  
  @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
    if gestureRecognizer.state == .began {
      let touchedPoint = gestureRecognizer.location(in: self.mapView)
      let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
      localLatitude = touchedCoordinates.latitude
      localLongitude = touchedCoordinates.longitude
      let annotation = MKPointAnnotation()
      annotation.coordinate = touchedCoordinates
      annotation.title = nameText.text
      annotation.subtitle = commentText.text
      self.mapView.addAnnotation(annotation)
      
    }
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation {
      return nil
    }
    let reuseID = "myAnnotation"
    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
      pinView?.canShowCallout = true
      pinView?.tintColor = UIColor.black
      let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
      pinView?.rightCalloutAccessoryView = button
    } else {
      pinView?.annotation = annotation
    }
    
    return pinView
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if let chosen = choosenPlace {
      let requestLocation = CLLocation(latitude: chosen.latitude, longitude: chosen.longitude)
      CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
        if let placemarks = placemarks {
          if placemarks.count > 0 {
            let newPlacemark = MKPlacemark(placemark: placemarks[0])
            let item = MKMapItem(placemark: newPlacemark)
            item.name = chosen.title
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            item.openInMaps(launchOptions: launchOptions)
          }
        }
      }
    }
  }
  
  @IBAction func saveButton(_ sender: Any) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
    let id = UUID()
    place = PlaceModel(id: id.uuidString, title: nameText.text!, subtitle: commentText.text!, latitude: localLatitude, longitude: localLongitude)
    if let place = place {
      newPlace.setValue(place.id, forKey: "id")
      newPlace.setValue(place.title, forKey: "title")
      newPlace.setValue(place.subtitle, forKey: "subtitle")
      newPlace.setValue(place.latitude, forKey: "latitude")
      newPlace.setValue(place.longitude, forKey: "longitude")
      do {
        try context.save()
        print("Saved")
      } catch {
        print("Error.")
      }
      
      NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
      navigationController?.popViewController(animated: true)
    }
  }
}

