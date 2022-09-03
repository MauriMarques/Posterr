//
//  ProfileInteractor.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import Foundation

protocol ProfileInteractable {
  var router: ProfileRouting? { get set }
  var presenter: ProfilePresentable { get }
  var listener: ProfileInteractableListerner? { get set }
  func reloadProfile()
}

protocol ProfileInteractableListerner: AnyObject {
  func didCloseProfile()
}

final class ProfileInteractor: ProfileInteractable {
  weak var router: ProfileRouting?
  weak var listener: ProfileInteractableListerner?

  var presenter: ProfilePresentable

  private let sessionService: SessionService
  private let postService: PostService

  init(presenter: ProfilePresentable,
       sessionService: SessionService,
       postService: PostService) {
    self.presenter = presenter
    self.sessionService = sessionService
    self.postService = postService
    self.presenter.listener = self
  }

  func reloadProfile() {
    didLoad()
  }
}

extension ProfileInteractor: ProfilePresentableListener {
  func didLoad() {
    guard let user = sessionService.user else {
      return
    }
    let posts = postService.postsByCreator(user,
                                           onDate: nil)
    presenter.loadUser(user)
    presenter.loadPosts(posts)
  }

  func didClickOnCreatePost() {
    router?.routeToCreatePost()
  }

  func didCancel() {
    listener?.didCloseProfile()
  }
}
