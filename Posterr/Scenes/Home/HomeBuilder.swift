//
//  HomeBuilder.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation

protocol HomeBuildable {
  func build() -> HomeRouting
}

struct HomeBuilder: HomeBuildable {

  private let sessionService: SessionService
  private let appConfig: PosterrAppConfig
  private let postService: PostService

  init(sessionService: SessionService, postService: PostService, appConfig: PosterrAppConfig) {
    self.sessionService = sessionService
    self.appConfig = appConfig
    self.postService = postService
  }

  func build() -> HomeRouting {
    let presenter = HomeViewController()
    let interactor = HomeInteractor(presenter: presenter,
                                    sessionService: sessionService,
                                    postService: postService)

    let createPostBuilder = CreatePostBuilder(sessionService: sessionService,
                                              appConfig: appConfig,
                                              postService: postService)
    let profileBuilder = ProfileBuilder(sessionService: sessionService,
                                        appConfig: appConfig,
                                        postService: postService)

    return HomeRouter(interactor: interactor,
                      viewController: presenter,
                      createPostBuilder: createPostBuilder,
                      profileBuilder: profileBuilder)
  }
}
