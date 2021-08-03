//
//  ViewController.swift
//  FileOperationsWithUIKit
//
//  Created by Yusuf Turan on 25.07.2021.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var enterDataTF: UITextField!
  @IBOutlet weak var showImage: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func writeData(_ sender: Any) {
    let data = enterDataTF.text!
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let filePath = dir.appendingPathComponent("file.txt")
      
      do {
        try data.write(to: filePath, atomically: false, encoding: String.Encoding.utf8)
        enterDataTF.text = ""
      } catch {
        print("Error when writing to file.")
      }
    }
  }
  
  @IBAction func readData(_ sender: Any) {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let filePath = dir.appendingPathComponent("file.txt")
      
      do {
        enterDataTF.text = try String(contentsOf: filePath, encoding: String.Encoding.utf8)
      } catch {
        print("Error when reading file.")
      }
    }
  }
  
  @IBAction func deleteData(_ sender: Any) {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let filePath = dir.appendingPathComponent("file.txt")
      if FileManager.default.fileExists(atPath: filePath.path) {
        do {
          try FileManager.default.removeItem(at: filePath)
          enterDataTF.text = ""
        } catch {
          print("Error when deleting file.")
        }
      }
    }
  }
  
  @IBAction func saveImage(_ sender: Any) {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let filePath = dir.appendingPathComponent("steve-jobs-image.jpg")
      let image = UIImage(named: "steve-jobs")
      do {
        try image!.jpegData(compressionQuality: 1)?.write(to: filePath)
      } catch {
        print("Error when writing to file.")
      }
    }
  }
  
  @IBAction func showImage(_ sender: Any) {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let filePath = dir.appendingPathComponent("steve-jobs-image.jpg")
      self.showImage.image = UIImage(contentsOfFile: filePath.path)
    }
  }
  
  @IBAction func deleteImage(_ sender: Any) {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let filePath = dir.appendingPathComponent("steve-jobs-image.jpg")
      if FileManager.default.fileExists(atPath: filePath.path) {
        do {
          try FileManager.default.removeItem(at: filePath)
        } catch {
          print("Error when deleting file.")
        }
      }
    }
  }
}

