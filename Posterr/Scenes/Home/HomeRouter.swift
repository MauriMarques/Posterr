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
  func routeToCreatePost(_ postType: PostType)
  func routeToProfile()
}

final class HomeRouter: HomeRouting {

  private var interactor: HomeInteractable
  private let viewController: UIViewController

  private let createPostBuilder: CreatePostBuildable
  private var createPostRouter: CreatePostRouting?

  private let profileBuilder: ProfileBuildable
  private var profileRouter: ProfileRouting?

  init(interactor: HomeInteractable,
       viewController: UIViewController,
       createPostBuilder: CreatePostBuildable,
       profileBuilder: ProfileBuildable) {
    self.interactor = interactor
    self.viewController = viewController
    self.createPostBuilder = createPostBuilder
    self.profileBuilder = profileBuilder
    self.interactor.router = self
  }

  func launch(from window: UIWindow) {
    window.rootViewController = UINavigationController(rootViewController: viewController)
    window.makeKeyAndVisible()
  }

  func routeToCreatePost(_ postType: PostType) {
    guard createPostRouter == nil else {
      return
    }
    createPostRouter = createPostBuilder.build(postType: postType,
                                               listener: self)
    guard let createPostViewController = createPostRouter?.start() else {
      return
    }
    createPostViewController.modalPresentationStyle = .fullScreen
    viewController.present(createPostViewController,
                           animated: true,
                           completion: nil)
  }

  func routeToProfile() {
    guard profileRouter == nil else {
      return
    }
    profileRouter = profileBuilder.build(listener: self)
    guard let profileViewController = profileRouter?.start() else {
      return
    }
    viewController.navigationController?.pushViewController(profileViewController,
                                                            animated: true)
  }
}

extension HomeRouter: CreatePostInteractbleListener {
  func didCreatePost(_ post: Post) {
    dismissCreatePostScene()
    interactor.reloadHome()
  }

  func didCloseCreatePost() {
    dismissCreatePostScene()
  }

  private func dismissCreatePostScene() {
    guard createPostRouter != nil else {
      return
    }
    viewController.presentedViewController?.dismiss(animated: true,
                                                    completion: nil)
    createPostRouter = nil
  }
}

extension HomeRouter: ProfileInteractableListerner {
  func didCloseProfile() {
    guard profileRouter != nil else {
      return
    }
    profileRouter = nil
    interactor.reloadHome()
  }
}
