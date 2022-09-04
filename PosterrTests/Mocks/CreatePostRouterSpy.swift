//
//  CreatePostRouterSpy.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
import UIKit
@testable import Posterr

final class CreatePostRouterSpy: CreatePostRouting {

  var didStart: Bool = false

  func start() -> UINavigationController {
    didStart = true
    return UINavigationController()
  }
}
