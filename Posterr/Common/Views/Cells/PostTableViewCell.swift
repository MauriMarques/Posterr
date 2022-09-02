//
//  PostTableViewCell.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

protocol PostTableCellViewModel {
  var postHeaderViewModel: PostHeaderViewModel { get }
  var contentText: String { get }
}

class PostTableViewCell: UITableViewCell, ViewCodable, ViewModelSettable {
  typealias ViewModel = PostTableCellViewModel

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
    contentLabel.text = viewModel.contentText
  }

  // MARK: ViewCodable

  func buildViewHierarchy() {
    contentView.addSubview(postHeaderView)
    contentView.addSubview(contentLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      postHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
      postHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
      contentLabel.leadingAnchor.constraint(equalTo: postHeaderView.leadingAnchor, constant: 10.0),
      contentLabel.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor, constant: 10.0),
      contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
    ])
  }
}
