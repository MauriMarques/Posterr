//
//  HomeBuilder.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation

protocol HomeBuildable {
  func build(sessionService: SessionService, postService: PostService) -> HomeRouting
}

struct HomeBuilder: HomeBuildable {

  func build(sessionService: SessionService, postService: PostService) -> HomeRouting {
    let presenter = HomeViewController()
    let interactor = HomeInteractor(presenter: presenter,
                                    sessionService: sessionService,
                                    postService: postService)

    let createPostBuilder = CreatePostBuilder(sessionService: sessionService,
                                              postService: postService)
    let profileBuilder = ProfileBuilder(sessionService: sessionService,
                                        postService: postService)

    return HomeRouter(interactor: interactor,
                      viewController: presenter,
                      createPostBuilder: createPostBuilder,
                      profileBuilder: profileBuilder)
  }
}
