//
//  PostsTableViewDataSource.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

protocol PostsTableViewDataSourcing: UITableViewDataSource {
  var posts: [Post]? { get set }
  var postsTableView: PostsTableView? { get set }
}

final class PostsTableViewDataSource: NSObject, PostsTableViewDataSourcing {

  var posts: [Post]? {
    didSet {
      guard let posts = posts else {
        return
      }
      if posts.isEmpty {
        postsTableView?.state = .empty
      } else {
        postsTableView?.state = .loaded
        postsTableView?.reloadData()
        postsTableView?.scrollToRow(at: IndexPath(row: 0,
                                                 section: 0),
                                   at: .top,
                                   animated: false)
      }
    }
  }

  var postsTableView: PostsTableView?

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    posts?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let post = posts?[indexPath.row] else {
      return UITableViewCell()
    }

    do {
      switch post.type {
      case .normal:
        let cell: PostTableViewCell = try dequeCell(PostTableViewCell.self,
                                                    in: tableView)
        cell.setViewModel(post)
        return cell
      case .quote:
        let cell: QuoteTableViewCell = try dequeCell(QuoteTableViewCell.self,
                                                     in: tableView)
        cell.setViewModel(post)
        return cell
      case .repost:
        let cell: RepostTableViewCell = try dequeCell(RepostTableViewCell.self,
                                                      in: tableView)
        cell.setViewModel(post)
        return cell
      }
    } catch {
      return UITableViewCell()
    }
  }

  private func dequeCell<T: CellIdentifiable>(_ type: T.Type,
                                              in tableView: UITableView) throws -> T {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: type.identifier) as? T else {
      throw PostTableError.noPostCellFound
    }
    return cell
  }
}
