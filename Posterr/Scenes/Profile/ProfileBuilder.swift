//
//  ProfileBuilder.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import Foundation

protocol ProfileBuildable {
  func build(listener: ProfileInteractableListerner?) -> ProfileRouting
}

struct ProfileBuilder: ProfileBuildable {

  private let sessionService: SessionService
  private let appConfig: PosterrAppConfig
  private let postService: PostService

  init(sessionService: SessionService, appConfig: PosterrAppConfig, postService: PostService) {
    self.sessionService = sessionService
    self.appConfig = appConfig
    self.postService = postService
  }

  func build(listener: ProfileInteractableListerner?) -> ProfileRouting {
    let presenter = ProfileViewController()
    let interactor = ProfileInteractor(presenter: presenter,
                                       sessionService: sessionService,
                                       postService: postService)

    let createPostBuilder = CreatePostBuilder(sessionService: sessionService,
                                              appConfig: appConfig,
                                              postService: postService)
    interactor.listener = listener
    return ProfileRouter(interactor: interactor,
                         viewController: presenter,
                         createPostBuilder: createPostBuilder)
  }
}
