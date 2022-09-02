//
//  RepostTableViewCell.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

protocol RepostTableViewCellViewModel {
  var postHeaderViewModel: PostHeaderViewModel { get }
  var contentText: String { get }
  var parentPostViewModel: ParentPostViewModel { get }
}

class RepostTableViewCell: UITableViewCell, ViewCodable, ViewModelSettable {
  typealias ViewModel = RepostTableViewCellViewModel

  lazy var postHeaderView: PostHeaderView = {
    let postHeaderView = PostHeaderView()
    postHeaderView.translatesAutoresizingMaskIntoConstraints = false
    return postHeaderView
  }()

  lazy var parentPostView: ParentPostView = {
    let postView = ParentPostView()
    postView.translatesAutoresizingMaskIntoConstraints = false
    return postView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCodableView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: ViewModelSettable

  func setViewModel(_ viewModel: ViewModel) {
    postHeaderView.setViewModel(viewModel.postHeaderViewModel)
    parentPostView.setViewModel(viewModel.parentPostViewModel)
  }

  // MARK: ViewCodable

  func buildViewHierarchy() {
    contentView.addSubview(postHeaderView)
    contentView.addSubview(parentPostView)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      postHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
      postHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
      parentPostView.leadingAnchor.constraint(equalTo: postHeaderView.leadingAnchor),
      parentPostView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
      parentPostView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      parentPostView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
    ])
  }
}
