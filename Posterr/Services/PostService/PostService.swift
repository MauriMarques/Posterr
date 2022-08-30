//
//  PostService.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation

protocol PostService {
  func allPosts() -> [Post]
  func postsByCreator(_ creator: User) -> [Post]
  func createPost(content: String, creator: User) -> Post?
  func repostPost(parentPost: Post, creator: User) -> Post?
  func quotePost(content: String, parentPost: Post, creator: User) -> Post?
}
