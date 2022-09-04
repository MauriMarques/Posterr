//
//  CreatePostInteractorListenerMock.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
@testable import Posterr

final class CreatePostInteractorListenerMock: CreatePostInteractbleListener {

  var didCreatePost: Post?
  var didCallCloseCreatePost: Bool = false

  func didCreatePost(_ post: Post) {
    didCreatePost = post
  }

  func didCloseCreatePost() {
    didCallCloseCreatePost = true
  }
}
