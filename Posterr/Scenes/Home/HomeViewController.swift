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
    let profileBarView = ProfileBarView(viewModel: ProfileBarView.ViewModel(userName: user.name))
    profileBarView.delegate = self
    let customBarButtonItem = UIBarButtonItem(customView: profileBarView)
    navigationItem.setLeftBarButton(customBarButtonItem, animated: false)
  }

  func loadPosts(_ posts: [Post]) {

  }

  func showErrorScreen() {

  }
}

extension HomeViewController: ProfileBarViewDelegate {
  func didTapProfileBarView(_ profileBarView: ProfileBarView) {
    listener?.didClickOnProfileSection()
  }
}
