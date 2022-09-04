//
//  HomeRouterSpy.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
import UIKit
@testable import Posterr

final class HomeRouterSpy: HomeRouting {

  var didCallLaunch: Bool = false
  var didCreatePostType: PostType?
  var didCallProfile: Bool = false

  func launch(from window: UIWindow) {
    didCallLaunch = true
  }

  func routeToCreatePost(_ postType: PostType) {
    didCreatePostType = postType
  }

  func routeToProfile() {
    didCallProfile = true
  }
}
