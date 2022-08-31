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
    listener?.didLoad()
  }
}

extension HomeViewController: HomePresentable {

  func loadUser(_ user: User) {

  }

  func loadPosts(_ posts: [Post]) {

  }

  func showErrorScreen() {

  }
}
