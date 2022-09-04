//
//  PostsTableView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

enum PostTableError: Error {
  case noPostCellFound
}

final class PostsTableView: UITableView {

  struct AccessibilityIdentifier {
    static let `self` = "post_table_view"
    static let emptyLabel = "empty_label"
  }

  enum State {
    case loaded
    case empty
  }

  var state: State = .empty {
    didSet {
      switch state {
      case .empty:
        backgroundView = emptyStateLabel
      case .loaded:
        backgroundView = nil
      }
    }
  }

  private let emptyStateLabel: UILabel = {
    let label = UILabel()
    label.text = L10n.postsEmptyText
    label.font = .boldSystemFont(ofSize: 24.0)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.accessibilityIdentifier = AccessibilityIdentifier.emptyLabel
    return label
  }()

  init() {
    super.init(frame: .zero, style: .plain)
    estimatedRowHeight = 200.0
    rowHeight = UITableView.automaticDimension
    register(PostTableViewCell.self,
             forCellReuseIdentifier: PostTableViewCell.identifier)
    register(QuoteTableViewCell.self,
             forCellReuseIdentifier: QuoteTableViewCell.identifier)
    register(RepostTableViewCell.self,
             forCellReuseIdentifier: RepostTableViewCell.identifier)
    accessibilityIdentifier = AccessibilityIdentifier.`self`
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
