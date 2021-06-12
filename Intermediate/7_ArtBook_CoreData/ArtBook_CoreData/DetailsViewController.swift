//
//  DetailsViewController.swift
//  ArtBook_CoreData
//
//  Created by Yusuf Turan on 12.06.2021.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: - PROPERTIES
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameText: UITextField!
  @IBOutlet weak var artistText: UITextField!
  @IBOutlet weak var yearText: UITextField!
  @IBOutlet weak var saveButtonView: UIButton!
  
  var chosenPainting: Art?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let chosen = chosenPainting {
      saveButtonView.isHidden = true
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let context = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Painting")
      let idString = chosen.id
      fetchRequest.predicate = NSPredicate(format: "id == %@", idString)
      fetchRequest.returnsObjectsAsFaults = false
      
      do {
        let results = try context.fetch(fetchRequest)
        if results.count > 0 {
          for result in results as! [NSManagedObject] {
            if let name = result.value(forKey: "name") as? String {
              self.nameText.text = name
              self.nameText.isEnabled = false
            }
            if let artist = result.value(forKey: "artist") as? String {
              self.artistText.text = artist
              self.artistText.isEnabled = false
            }
            if let year = result.value(forKey: "year") as? Int {
              self.yearText.text = String(year)
              self.yearText.isEnabled = false
            }
            if let imageData = result.value(forKey: "image") as? Data {
              let image = UIImage(data: imageData)
              self.imageView.image = image
            }
          }
        }
        
      } catch {
        print("Can't fetch item data")
      }
    } else {
      saveButtonView.isHidden = false
      saveButtonView.isEnabled = false
      nameText.text = ""
      artistText.text = ""
      yearText.text = ""
    }
    
    // MARK: - RECOGNIZERS
    //disable keyboard when clicking somewhere on view.
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    view.addGestureRecognizer(gestureRecognizer)
    
    imageView.isUserInteractionEnabled = true
    let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapRecognizer))
    imageView.addGestureRecognizer(imageTapRecognizer)
  }
  
  @objc func hideKeyboard() {
    view.endEditing(true)
  }
  
  @objc func imageTapRecognizer() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.sourceType = .photoLibrary
    picker.allowsEditing = true
    present(picker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    imageView.image = info[.editedImage] as? UIImage
    saveButtonView.isEnabled = true
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveButton(_ sender: Any) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Painting", into: context)
    
    ///Attributes
    guard let year = Int(yearText.text!) else { return }
    
    let data = imageView.image?.jpegData(compressionQuality: 0.5)
    let id = UUID()
    let newArt = Art(id: id.uuidString,name: nameText.text!, artist: artistText.text!, year: year, image: data!)
    newPainting.setValue(newArt.id, forKey: "id")
    newPainting.setValue(newArt.name, forKey: "name")
    newPainting.setValue(newArt.artist, forKey: "artist")
    newPainting.setValue(newArt.image, forKey: "image")
    newPainting.setValue(newArt.year, forKey: "year")
    
    do {
      try context.save()
    } catch {
      print("Error on Save!")
    }
    NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
    //go back to prev view
    self.navigationController?.popViewController(animated: true)
  }
}
