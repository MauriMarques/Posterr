//
//  HomeInteractor.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation

protocol HomeInteractable {
  var router: HomeRouting? { get set }
  var presenter: HomePresentable { get }
  func reloadHome()
}

final class HomeInteractor: HomeInteractable {

  weak var router: HomeRouting?

  var presenter: HomePresentable

  private let sessionService: SessionService
  private let postService: PostService

  init(presenter: HomePresentable,
       sessionService: SessionService,
       postService: PostService) {
    self.presenter = presenter
    self.sessionService = sessionService
    self.postService = postService
    self.presenter.listener = self
  }

  func reloadHome() {
    didLoad()
  }
}

extension HomeInteractor: HomePresentableListener {

  func didLoad() {
    guard let user = sessionService.user else {
      presenter.showErrorScreen()
      return
    }
    let posts = postService.allPosts()
    presenter.loadUser(user)
    presenter.loadPosts(posts)
  }

  func didClickOnProfileSection() {
    router?.routeToProfile()
  }

  func didClickOnCreatePost() {
    router?.routeToCreatePost(.normal)
  }

  func didClickOnRepostPost(_ post: Post) {
    router?.routeToCreatePost(.repost(post))
  }

  func didClickOnQuotePost(_ post: Post) {
    router?.routeToCreatePost(.quote(post))
  }
}
