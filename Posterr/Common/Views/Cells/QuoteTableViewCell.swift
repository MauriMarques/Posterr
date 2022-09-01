//
//  QuoteTableViewCell.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

protocol QuoteTableViewCellViewModel: PostTableCellViewModel {
  var parentPostViewModel: ParentPostViewViewModel { get }
}
class QuoteTableViewCell: PostTableViewCell {
  typealias ViewModel = QuoteTableViewCellViewModel

  lazy var parentPostView: ParentPostView = {
    let postView = ParentPostView()
    postView.translatesAutoresizingMaskIntoConstraints = false
    return postView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setViewModel(_ viewModel: ViewModel) {
    postHeaderView.setViewModel(viewModel.postHeaderViewModel)
    contentLabel.text = viewModel.contentText
    parentPostView.setViewModel(viewModel.parentPostViewModel)
  }

  // MARK: ViewCodable

  override func buildViewHierarchy() {
    super.buildViewHierarchy()
    contentView.addSubview(parentPostView)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      postHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
      postHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
      contentLabel.leadingAnchor.constraint(equalTo: postHeaderView.leadingAnchor, constant: 10.0),
      contentLabel.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor, constant: 10.0),
      contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      parentPostView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
      parentPostView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor),
      parentPostView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
      parentPostView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
    ])
  }
}
