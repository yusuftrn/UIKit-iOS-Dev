//
//  UploadVC.swift
//  InstaParse
//
//  Created by Yusuf Turan on 7.07.2021.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var postImage: UIImageView!
  @IBOutlet weak var commentText: UITextField!
  @IBOutlet weak var postButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(UploadVC.hideKeyboard))
    self.view.addGestureRecognizer(keyboardRecognizer)
    
    postImage.isUserInteractionEnabled = true
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UploadVC.chooseImage))
    postImage.addGestureRecognizer(gestureRecognizer)
    
    postButton.isEnabled = false
    
  }
  @objc func hideKeyboard() {
    self.view.endEditing(true)
  }
  @objc func chooseImage() {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = .photoLibrary
    pickerController.allowsEditing = true
    present(pickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    postImage.image = info[.originalImage] as? UIImage
    self.dismiss(animated: true, completion: nil)
    postButton.isEnabled = true
  }
  
  @IBAction func postButton(_ sender: Any) {
    postButton.isEnabled = false
    
    let object = PFObject(className: "Posts")
    
    let data = postImage.image?.jpegData(compressionQuality: 0.5)
    let pfImage = PFFileObject(name: "image", data: data!)
    
    object["postid"] = UUID().uuidString
    object["postowner"] = PFUser.current()!.username!
    object["postcomment"] = commentText.text
    object["postimage"] = pfImage
   
    object.saveInBackground { success, err in
      if err != nil {
        self.alert("Error with Upload", err!.localizedDescription)
      } else {
        self.commentText.text = ""
        self.postImage.image = UIImage(named: "placeholder")
        self.tabBarController?.selectedIndex = 0
        
        NotificationCenter.default.post(name: NSNotification.Name("newPost"), object: nil)
      }
    }
  }
  
  public func alert(_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(okButton)
    present(alert, animated: true, completion: nil)
  }
}
