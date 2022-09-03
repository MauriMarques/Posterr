//
//  CreatePostViewController.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

protocol CreatePostPresentable {
  var listener: CreatePostPresentableListener? { get set }
  func loadUser(_ user: User)
  func showPostsCreationLimitReachedAlert()
}

protocol CreatePostPresentableListener: AnyObject {
  func didLoad()
  func didClickOnCreatePost(content: String?)
  func didCancel()
}

final class CreatePostViewController: UIViewController {
  weak var listener: CreatePostPresentableListener?

  private lazy var createPostView: UIView = {
    switch postType {
    case .normal:
      let createPostView = CreatePostView(maxCharactersAllowed: appConfig.postMaxLegnth)
      createPostView.delegate = self
      return createPostView
    case let .quote(parentPost):
      let createQuoteView = CreatePostView(maxCharactersAllowed: appConfig.postMaxLegnth,
                                           parentPostViewModel: DefaultParentPostViewModel(post: parentPost))
      createQuoteView.delegate = self
      return createQuoteView
    case let .repost(parentPost):
      let createRepostView = CreateRepostView(parentPostViewModel: DefaultParentPostViewModel(post: parentPost))
      createRepostView.delegate = self
      return createRepostView
    }
  }()

  private let postType: PostType
  private let appConfig: PosterrAppConfig

  init(postType: PostType,
       appConfig: PosterrAppConfig) {
    self.postType = postType
    self.appConfig = appConfig
    super.init(nibName: nil,
               bundle: nil)
  }

  override func loadView() {
    view = createPostView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setUpNavigationBar()
    listener?.didLoad()
    _ = (view as? CreatePostView)?.becomeFirstResponder()
  }

  private func setUpNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

    let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                              target: self,
                                              action: #selector(didClickOnCancel))
    cancelBarButtonItem.tintColor = .black
    navigationItem.setRightBarButton(cancelBarButtonItem,
                                     animated: false)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc
  private func didClickOnCancel() {
    listener?.didCancel()
  }
}

extension CreatePostViewController: CreatePostPresentable {

  func loadUser(_ user: User) {
    let profileBarView = ProfileBarView()
    profileBarView.userName = user.name
    let customBarButtonItem = UIBarButtonItem(customView: profileBarView)
    navigationItem.setLeftBarButton(customBarButtonItem, animated: false)
  }

  func showPostsCreationLimitReachedAlert() {
    let alert = UIAlertController(title: "\u{2639} \n Too many posts for today",
                                  message: "Sorry, you have reached the 4 posts per day limit. But no worries, you can continue by tomorrow.",
                                  preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { [weak self] _ in
      self?.listener?.didCancel()
    }))
    self.present(alert, animated: true, completion: nil)
  }
}

extension CreatePostViewController: CreatePostViewDelegate {
  func didClickOnCreatePost(content: String) {
    listener?.didClickOnCreatePost(content: content)
  }
}

extension CreatePostViewController: CreateRepostViewDelegate {
  func didClickOnRepostPost() {
    listener?.didClickOnCreatePost(content: nil)
  }
}
