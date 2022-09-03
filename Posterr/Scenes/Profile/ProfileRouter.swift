//
//  ProfileRouter.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import Foundation
import UIKit

protocol ProfileRouting: AnyObject {
  func start() -> UIViewController
  func routeToCreatePost()
}

final class ProfileRouter: ProfileRouting {

  private var interactor: ProfileInteractable
  private let viewController: UIViewController

  private let createPostBuilder: CreatePostBuildable
  private var createPostRouter: CreatePostRouting?

  init(interactor: ProfileInteractable,
       viewController: UIViewController,
       createPostBuilder: CreatePostBuildable) {
    self.interactor = interactor
    self.viewController = viewController
    self.createPostBuilder = createPostBuilder
    self.interactor.router = self
  }

  func start() -> UIViewController {
    return viewController
  }

  func routeToCreatePost() {
    guard createPostRouter == nil else {
      return
    }
    createPostRouter = createPostBuilder.build(postType: .normal,
                                               listener: self)
    guard let createPostViewController = createPostRouter?.start() else {
      return
    }
    createPostViewController.modalPresentationStyle = .fullScreen
    viewController.present(createPostViewController,
                           animated: true,
                           completion: nil)
  }
}

extension ProfileRouter: CreatePostInteractbleListener {
  func didCreatePost(_ post: Post) {
    dismissCreatePostScene()
    interactor.reloadProfile()
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
