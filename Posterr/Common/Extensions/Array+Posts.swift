//
//  Array+Posts.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import Foundation

extension Array where Element: Post {

  var postsCount: Int {
    filter { $0.type == .normal }.count
  }

  var quotesCount: Int {
    filter { $0.type == .quote }.count
  }

  var repostCount: Int {
    filter { $0.type == .repost }.count
  }
}
