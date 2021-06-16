//
//  UploadViewController.swift
//  InstaClone
//
//  Created by Yusuf Turan on 14.06.2021.
//

import UIKit
import Firebase


class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var commentText: UITextField!
  @IBOutlet weak var uploadButtonView: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.isUserInteractionEnabled = true
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
    imageView.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc func chooseImage() {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = .photoLibrary
    present(pickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    imageView.image = info[.originalImage] as? UIImage
    self.dismiss(animated: true, completion: nil)
  }
  
  func makeAlert(titleInput: String, messageInput: String) {
    let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okButton)
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func uploadButton(_ sender: Any) {
    let storage = Storage.storage()
    let storageRef = storage.reference()
    
    let mediaFolder = storageRef.child("media")
    
    if let data = imageView.image?.jpegData(compressionQuality: 0.8) {
      let randomName = UUID().uuidString
      let imageRef = mediaFolder.child("\(randomName).jpeg")
      imageRef.putData(data, metadata: nil) { (metadata, err) in
        if err != nil {
          self.makeAlert(titleInput: "Error!", messageInput: err?.localizedDescription ?? "Error")
        } else {
          imageRef.downloadURL { url, err in
            if err == nil {
              let imageUrl = url?.absoluteString
              //DB:
              let firestoreDB = Firestore.firestore()
              var firestoreRef: DocumentReference? = nil
              let firestorePost = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.commentText.text!, "date": FieldValue.serverTimestamp(), "likes": 0] as [String: Any]
              firestoreRef = firestoreDB.collection("Posts").addDocument(data: firestorePost) { err in
                if err != nil {
                  self.makeAlert(titleInput: "Error", messageInput: err?.localizedDescription ?? "Error!!")
                } else {
                  self.imageView.image = UIImage(named: "placeholder")
                  self.commentText.text = ""
                  self.tabBarController?.selectedIndex = 0
                }
              }
            }
          }
        }
      }
    }
    
    
  }
}
