//
//  PostsTableView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

final class PostsTableView: UITableView {

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
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
