//
//  CryptoViewCellTableViewCell.swift
//  CryptoMMVM
//
//  Created by Yusuf Turan on 7.07.2021.
//

import UIKit

class CryptoViewCellTableViewCell: UITableViewCell {
  
  @IBOutlet weak var cryptoName: UILabel!
  @IBOutlet weak var cryptoPrice: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
