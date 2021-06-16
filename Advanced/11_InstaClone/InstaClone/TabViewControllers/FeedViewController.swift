//
//  FeedViewController.swift
//  InstaClone
//
//  Created by Yusuf Turan on 14.06.2021.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
    cell.userEmailField.text = "user@email.com"
    cell.likeCountLabel.text = "0"
    cell.commentLabel.text = "selam kardeşim"
    cell.imageView?.image = UIImage(named: "placeholder")
    return cell
  }
}
