//
//  Post.swift
//  InstaParse
//
//  Created by Yusuf Turan on 13.07.2021.
//

import Foundation
import Parse

struct Post {
  let postOwner: String?
  let postComment: String?
  let postID: String?
  let postImage: PFFileObject?
}
