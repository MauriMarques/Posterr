//
//  CreatePostBuilder.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation

protocol CreatePostBuildable {
  func build(postType: PostType, listener: CreatePostInteractbleListener?) -> CreatePostRouting
}

struct CreatePostBuilder: CreatePostBuildable {

  private let sessionService: SessionService
  private let appConfig: PosterrAppConfig
  private let postService: PostService

  init(sessionService: SessionService,
       appConfig: PosterrAppConfig,
       postService: PostService) {
    self.sessionService = sessionService
    self.appConfig = appConfig
    self.postService = postService
  }

  func build(postType: PostType,
             listener: CreatePostInteractbleListener?) -> CreatePostRouting {
    let presenter = CreatePostViewController(postType: postType,
                                             appConfig: appConfig)
    let interactor = CreatePostInteractor(presenter: presenter,
                                          sessionService: sessionService,
                                          appConfig: appConfig,
                                          postService: postService,
                                          postType: postType)
    interactor.listener = listener
    return CreatePostRouter(interactor: interactor,
                            viewController: presenter)
  }
}
