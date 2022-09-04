//
//  ProfileRouterSpy.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
import UIKit
@testable import Posterr

final class ProfileRouterSpy: ProfileRouting {

  var didStart: Bool = false
  var didCallRouterToCreatePost: Bool = false

  func start() -> UIViewController {
    didStart = true
    return UIViewController()
  }

  func routeToCreatePost() {
    didCallRouterToCreatePost = true
  }
}
