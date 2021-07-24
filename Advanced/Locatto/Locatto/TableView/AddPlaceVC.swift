//
//  AddPlaceVC.swift
//  Locatto
//
//  Created by Yusuf Turan on 23.06.2021.
//

import UIKit

class AddPlaceVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  @IBOutlet weak var placeNameField: UITextField!
  @IBOutlet weak var placeTypeField: UITextField!
  @IBOutlet weak var placeAthmosField: UITextField!
  @IBOutlet weak var placeImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    placeImage.isUserInteractionEnabled = true
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
    placeImage.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc func chooseImage() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.sourceType = .photoLibrary
    self.present(picker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    placeImage.image = info[.originalImage] as? UIImage
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func nextButtonClicked(_ sender: Any) {
    let place = PlaceData.sharedInstance
    if placeNameField.text != nil &&
        placeTypeField.text != nil &&
        placeAthmosField.text != nil {
      if let choosenImage = placeImage.image {
        place.placeName = placeNameField.text!
        place.placeType = placeTypeField.text!
        place.placeAthmos = placeAthmosField.text!
        place.placeImage = choosenImage
      }
      self.performSegue(withIdentifier: "toMapVC", sender: nil)
    } else {
      let alert = UIAlertController(title: "ERROR", message: "PlaceName,Type or Athmosphere is null", preferredStyle: .alert)
      let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okButton)
      self.present(alert, animated: true, completion: nil)
    }
  }
}
