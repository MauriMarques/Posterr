//
//  CreatePostRouter.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

protocol CreatePostRouting: AnyObject {
  func start() -> UINavigationController
}

class CreatePostRouter: CreatePostRouting {

  private var interactor: CreatePostInteractable
  private let viewController: UIViewController

  init(interactor: CreatePostInteractable, viewController: UIViewController) {
    self.interactor = interactor
    self.viewController = viewController
    self.interactor.router = self
  }

  func start() -> UINavigationController {
    UINavigationController(rootViewController: viewController)
  }
}
