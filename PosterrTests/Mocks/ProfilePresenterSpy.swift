//
//  ProfilePresenterSpy.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
@testable import Posterr

final class ProfilePresenterSpy: ProfilePresentable {
  var listener: ProfilePresentableListener?
  var loadedUser: User?
  var loadedPosts: [Post]?

  func loadUser(_ user: User) {
    loadedUser = user
  }

  func loadPosts(_ posts: [Post]) {
    loadedPosts = posts
  }
}
