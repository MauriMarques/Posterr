//
//  PostsServiceMock.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
@testable import Posterr

final class PostsServiceMock: PostService {

  var posts: [Post]?
  var createdPost: Post?

  func allPosts() -> [Post] {
    posts ?? []
  }

  func postsByCreator(_ creator: User, onDate date: Date?) -> [Post] {
    posts ?? []
  }

  func createPost(content: String, creator: User) -> Post? {
    createdPost
  }

  func repostPost(parentPost: Post, creator: User) -> Post? {
    createdPost
  }

  func quotePost(content: String, parentPost: Post, creator: User) -> Post? {
    createdPost
  }
}
