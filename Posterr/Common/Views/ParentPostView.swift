//
//  ParentPostView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

protocol ParentPostViewModel {
  var parentPostHeaderViewModel: PostHeaderViewModel { get }
  var parentContentText: String { get }
}

struct DefaultParentPostViewModel: ParentPostViewModel {
  var parentPostHeaderViewModel: PostHeaderViewModel {
    switch post.type {
    case .repost:
      return post.parentPostHeaderViewModel
    case .normal, .quote:
      return post
    }
  }

  var parentContentText: String {
    switch post.type {
    case .repost:
      return post.parentPost?.content ?? ""
    case .normal, .quote:
      return post.content ?? ""
    }
  }

  private let post: Post

  init(post: Post) {
    self.post = post
  }
}

class ParentPostView: UIView {

  lazy var postHeaderView: PostHeaderView = {
    let postHeaderView = PostHeaderView()
    postHeaderView.translatesAutoresizingMaskIntoConstraints = false
    return postHeaderView
  }()

  lazy var contentLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()

  init() {
    super.init(frame: .zero)
    setupCodableView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ParentPostView: ViewModelSettable {
  func setViewModel(_ viewModel: ParentPostViewModel) {
    postHeaderView.setViewModel(viewModel.parentPostHeaderViewModel)
    contentLabel.text = viewModel.parentContentText
  }
}

extension ParentPostView: ViewCodable {

  func buildViewHierarchy() {
    addSubview(postHeaderView)
    addSubview(contentLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      postHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
      postHeaderView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
      contentLabel.leadingAnchor.constraint(equalTo: postHeaderView.leadingAnchor),
      contentLabel.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor, constant: 10.0),
      contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
      contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
    ])
  }
}
