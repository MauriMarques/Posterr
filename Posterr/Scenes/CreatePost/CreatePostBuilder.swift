//
//  CreatePostBuilder.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation

enum PostType {
  case normal
  case quote(Post)
  case repost(Post)
}

protocol CreatePostBuildable {
  func build(postType: PostType, listener: CreatePostInteractbleListener?) -> CreatePostRouting
}

struct CreatePostBuilder: CreatePostBuildable {

  private let sessionService: SessionService
  private let postService: PostService

  init(sessionService: SessionService,
       postService: PostService) {
    self.sessionService = sessionService
    self.postService = postService
  }

  func build(postType: PostType,
             listener: CreatePostInteractbleListener?) -> CreatePostRouting {
    let presenter = CreatePostViewController(postType: postType)
    let interactor = CreatePostInteractor(presenter: presenter,
                                          sessionService: sessionService,
                                          postService: postService,
                                          postType: postType)
    interactor.listener = listener
    return CreatePostRouter(interactor: interactor,
                            viewController: presenter)
  }
}
