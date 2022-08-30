//
//  Post.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation

class Post {

  enum `Type` {
    case normal
    case repost
    case quote
  }

  let id: Int64
  let creator: User
  let creationTimestamp: TimeInterval
  let content: String?
  let parentPost: Post?

  var type: `Type` {
    guard parentPost == nil else {
      if content != nil {
        return .quote
      } else {
        return .repost
      }
    }
    return .normal
  }

  init(id: Int64,
       creator: User,
       creationTimestamp: TimeInterval,
       content: String?,
       parentPost: Post?) {
    self.id = id
    self.creator = creator
    self.creationTimestamp = creationTimestamp
    self.content = content
    self.parentPost = parentPost
  }
}

extension Post: Equatable {
  static func == (lhs: Post, rhs: Post) -> Bool {
    (lhs.id == rhs.id && lhs.content == rhs.content && lhs.creationTimestamp == rhs.creationTimestamp && lhs.creator == rhs.creator && lhs.parentPost == rhs.parentPost)
  }
}
