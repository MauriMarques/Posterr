//
//  ProfileViewController.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import Foundation
import UIKit

protocol ProfilePresentable {
  func loadUser(_ user: User)
  func loadPosts(_ posts: [Post])
  var listener: ProfilePresentableListener? { get set }
}

protocol ProfilePresentableListener: AnyObject {
  func didLoad()
  func didClickOnCreatePost()
  func didCancel()
}

final class ProfileViewController: UIViewController {

  weak var listener: ProfilePresentableListener?

  private var user: User?

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      profileHeaderView,
      postsTableView
    ])
    stackView.backgroundColor = .white
    stackView.axis = .vertical
    return stackView
  }()

  private lazy var profileHeaderView: ProfileHeaderView = {
    let profileHeaderView = ProfileHeaderView()
    return profileHeaderView
  }()

  private lazy var postsTableView: PostsTableView = {
    let tableView = PostsTableView()
    tableView.allowsSelection = false
    tableView.dataSource = postsTableViewDataSource
    return tableView
  }()

  var postsTableViewDataSource: PostsTableViewDataSourcing

  init(postsTableViewDataSource: PostsTableViewDataSourcing = PostsTableViewDataSource()) {
    self.postsTableViewDataSource = postsTableViewDataSource
    super.init(nibName: nil,
               bundle: nil)
    postsTableViewDataSource.postsTableView = postsTableView
    title = "Profile"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    edgesForExtendedLayout = []
    setUpNavigationBar()
    listener?.didLoad()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    if self.isMovingFromParent {
      listener?.didCancel()
    }
  }

  override func loadView() {
    view = stackView
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

    let createPostBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                  target: self, action: #selector(didClickOnCreatePost))
    navigationItem.setRightBarButton(createPostBarButtonItem,
                                     animated: false)
  }

  @objc
  private func didClickOnCreatePost() {
    listener?.didClickOnCreatePost()
  }
}

extension ProfileViewController: ProfilePresentable {

  func loadUser(_ user: User) {
    self.user = user
  }

  func loadPosts(_ posts: [Post]) {
    guard let user = user else {
      return
    }
    profileHeaderView.setViewModel(DefaultProfileHeaderViewModel(user: user,
                                                                 userPosts: posts))
    postsTableViewDataSource.posts = posts
  }
}

struct DefaultProfileHeaderViewModel: ProfileHeaderViewModel {
  let user: User
  let userPosts: [Post]

  var userName: String {
    user.name
  }

  var accountCreationDateString: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM dd, YYYY"
    let date = Date(timeIntervalSince1970: user.creationTimestamp)
    return dateFormatter.string(from: date)
  }

  var createdPostsCount: Int {
    userPosts.postsCount
  }

  var createdQuotesCount: Int {
    userPosts.quotesCount
  }

  var createdRepostsCount: Int {
    userPosts.repostCount
  }

  init(user: User, userPosts: [Post]) {
    self.user = user
    self.userPosts = userPosts
  }
}
