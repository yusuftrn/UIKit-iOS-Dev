//
//  FeedCell.swift
//  InstaParse
//
//  Created by Yusuf Turan on 13.07.2021.
//

import UIKit
import Parse

class FeedCell: UITableViewCell {
  
  @IBOutlet weak var postImage: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var postUUID: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    postUUID.isHidden = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: true)
  }
  
  @IBAction func likeButton(_ sender: Any) {
    let likeObject = PFObject(className: "Likes")
    likeObject["from"] = PFUser.current()!.username!
    likeObject["to"] = userName.text
    
    likeObject.saveInBackground { success, err in
      if err != nil {
        self.alert("Like Error", err!.localizedDescription)
      } else {
        print("Saved")
      }
    }
  }
  @IBAction func commentButton(_ sender: Any) {
    let commentObject = PFObject(className: "Comments")
    commentObject["from"] = PFUser.current()!.username!
    commentObject["to"] = userName.text
    
    commentObject.saveInBackground { success, err in
      if err != nil {
        self.alert("Like Error", err!.localizedDescription)
      } else {
        print("Saved")
      }
    }
  }
  
  public func alert(_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(okButton)
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
  }
  
}
