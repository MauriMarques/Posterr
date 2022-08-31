//
//  HomeRouter.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

protocol HomeRouting: AnyObject {
  func launch(from window: UIWindow)
  func routeToCreatePost()
  func routeToProfile()
}

class HomeRouter: HomeRouting {

  private var interactor: HomeInteractable
  private let viewController: UIViewController

  init(interactor: HomeInteractable, viewController: UIViewController) {
    self.interactor = interactor
    self.viewController = viewController
    self.interactor.router = self
  }

  func launch(from window: UIWindow) {
    window.rootViewController = UINavigationController(rootViewController: viewController)
    window.makeKeyAndVisible()
  }

  func routeToCreatePost() {

  }

  func routeToProfile() {

  }
}
