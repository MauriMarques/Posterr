//
//  PostType.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 02/09/22.
//

import Foundation

enum PostType {
  case normal
  case quote(Post)
  case repost(Post)
}
