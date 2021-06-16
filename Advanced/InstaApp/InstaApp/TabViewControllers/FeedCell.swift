//
//  FeedCell.swift
//  InstaApp
//
//  Created by Yusuf Turan on 17.06.2021.
//

import UIKit

class FeedCell: UITableViewCell {
  @IBOutlet weak var userEmailField: UILabel!
  @IBOutlet weak var feedImageView: UIImageView!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var likeCountLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  @IBAction func likeButton(_ sender: Any) {
  }
}
