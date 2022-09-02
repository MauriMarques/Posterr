//
//  HomeViewController.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

protocol HomePresentable {
  var listener: HomePresentableListener? { get set }
  func loadUser(_ user: User)
  func loadPosts(_ posts: [Post])
  func showErrorScreen()
}

protocol HomePresentableListener: AnyObject {
  func didLoad()
  func didClickOnProfileSection()
  func didClickOnCreatePost()
  func didClickOnRepostPost(_ post: Post)
  func didClickOnQuotePost(_ post: Post)
}

class HomeViewController: UIViewController {
  weak var listener: HomePresentableListener?

  private lazy var postsTableView: PostsTableView = {
    let tableView = PostsTableView()
    tableView.dataSource = postsTableViewDataSource
    tableView.delegate = self
    return tableView
  }()

  var postsTableViewDataSource: PostsTableViewDataSourcing

  init(postsTableViewDataSource: PostsTableViewDataSourcing = PostsTableViewDataSource()) {
    self.postsTableViewDataSource = postsTableViewDataSource
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    view = postsTableView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setUpNavigationBar()
    listener?.didLoad()
  }

  private func setUpNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

    let createPostBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                  target: self, action: #selector(didClickOnCreatePost))
    createPostBarButtonItem.tintColor = .black
    navigationItem.setRightBarButton(createPostBarButtonItem,
                                     animated: false)
  }

  @objc
  private func didClickOnProfileButton() {
    listener?.didClickOnProfileSection()
  }

  @objc
  private func didClickOnCreatePost() {
    listener?.didClickOnCreatePost()
  }
}

extension HomeViewController: HomePresentable {

  func loadUser(_ user: User) {
    let profileBarView = ProfileBarView()
    profileBarView.userName = user.name
    profileBarView.delegate = self
    let customBarButtonItem = UIBarButtonItem(customView: profileBarView)
    navigationItem.setLeftBarButton(customBarButtonItem,
                                    animated: false)
  }

  func loadPosts(_ posts: [Post]) {
    self.postsTableViewDataSource.posts = posts
    postsTableView.reloadData()
    postsTableView.scrollToRow(at: IndexPath(row: 0,
                                             section: 0),
                               at: .top,
                               animated: false)
  }

  func showErrorScreen() {

  }
}

extension HomeViewController: ProfileBarViewDelegate {
  func didTapProfileBarView(_ profileBarView: ProfileBarView) {
    listener?.didClickOnProfileSection()
  }
}

enum PostTableError: Error {
  case noPostCellFound
}

extension HomeViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    guard let post = postsTableViewDataSource.posts?[indexPath.row] else {
      return
    }

    let alertTitle = "\(post.creator.name) - \(post.creationDateString)"

    let alert = UIAlertController(title: alertTitle,
                                  message: nil,
                                  preferredStyle: .actionSheet)

    alert.addAction(UIAlertAction(title: "Repost",
                                  style: .default ,
                                  handler: { [weak self] _ in
      self?.listener?.didClickOnRepostPost(post)
    }))

    alert.addAction(UIAlertAction(title: "Quote",
                                  style: .default ,
                                  handler: { [weak self] _ in
      self?.listener?.didClickOnQuotePost(post)
    }))

    alert.addAction(UIAlertAction(title: "Cancel",
                                  style: .cancel,
                                  handler: nil))

    present(alert, animated: true, completion: nil)
  }
}
