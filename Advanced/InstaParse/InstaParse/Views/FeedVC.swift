//
//  FeedVC.swift
//  InstaParse
//
//  Created by Yusuf Turan on 7.07.2021.
//

import UIKit
import Parse

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  
  @IBOutlet weak var tableView: UITableView!
  var posts = [Post]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    getData()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    NotificationCenter.default.addObserver(self, selector: #selector(FeedVC.getData), name: NSNotification.Name("newPost"), object: nil)
  }
  
  @objc func getData() {
    let query =  PFQuery(className: "Posts")
    query.addDescendingOrder("createdAt")
    query.findObjectsInBackground { objects, err in
      if err != nil {
        self.alert("Download Error", err!.localizedDescription)
      } else {
        self.posts.removeAll(keepingCapacity: false)
        if objects!.count > 0 {
          for obj in objects! {
            let post = Post(
              postOwner: obj.object(forKey: "postowner") as? String,
              postComment: obj.object(forKey: "postcomment") as? String,
              postID: obj.object(forKey: "postid") as? String,
              postImage: obj.object(forKey: "postimage") as? PFFileObject
            )
            self.posts.append(post)
          }
          self.tableView.reloadData()
        }
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
    cell.userName.text = posts[indexPath.row].postOwner
    cell.commentLabel.text = posts[indexPath.row].postComment
    cell.postUUID.text = posts[indexPath.row].postID
    
    posts[indexPath.row].postImage?.getDataInBackground(block: { data, err in
      if err != nil {
        self.alert("Image Download Error", err!.localizedDescription)
      } else {
        cell.postImage.image = UIImage(data: data!)
      }
    })
    
    return cell
  }
  
  @IBAction func logOut(_ sender: Any) {
    PFUser.logOutInBackground { err in
      if err != nil {
        self.alert("Error", err!.localizedDescription)
      } else {
        self.performSegue(withIdentifier: "toSignIn", sender: nil)
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
