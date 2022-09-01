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
}

class HomeViewController: UIViewController {
  weak var listener: HomePresentableListener?

  private lazy var postsTableView: PostsTableView = {
    let tableView = PostsTableView()
    tableView.dataSource = postsTableViewDataSource
    tableView.delegate = self
    return tableView
  }()

  var postsTableViewDataSource: PostsTableViewDataSourcing {
    didSet {
      postsTableView.reloadData()
    }
  }

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
  }

  @objc
  private func didClickOnProfileButton() {
    listener?.didClickOnProfileSection()
  }
}

extension HomeViewController: HomePresentable {

  func loadUser(_ user: User) {
    let profileBarView = ProfileBarView()
    profileBarView.userName = user.name
    profileBarView.delegate = self
    let customBarButtonItem = UIBarButtonItem(customView: profileBarView)
    navigationItem.setLeftBarButton(customBarButtonItem, animated: false)
  }

  func loadPosts(_ posts: [Post]) {
    self.postsTableViewDataSource.posts = posts
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

extension HomeViewController: UITableViewDelegate {}
