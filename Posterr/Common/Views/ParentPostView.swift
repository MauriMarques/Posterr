//
//  ParentPostView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

protocol ParentPostViewViewModel {
  var parentPostHeaderViewModel: PostHeaderViewViewModel { get }
  var parentContentText: String { get }
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
  func setViewModel(_ viewModel: ParentPostViewViewModel) {
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
