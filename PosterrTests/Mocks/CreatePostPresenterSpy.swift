//
//  CreatePostPresenterMock.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
@testable import Posterr

final class CreatePostPresenterSpy: CreatePostPresentable {

  var listener: CreatePostPresentableListener?

  var didCallShowPostsCreationLimitReachedAlert: Bool = false
  var loadedUser: User?

  func showPostsCreationLimitReachedAlert() {
    didCallShowPostsCreationLimitReachedAlert = true
  }

  func loadUser(_ user: User) {
    loadedUser = user
  }
}
