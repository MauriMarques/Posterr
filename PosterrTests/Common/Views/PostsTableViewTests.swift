//
//  PostsTableViewTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

final class PostsTableViewTests: XCTestCase, SnapshotViewTestable {

  var sut: PostsTableView?

  var dataSource: PostsTableViewDataSource?

  var containerSize: CGSize = CGSize(width: 320, height: 500)

  var record: Bool = false

  var testName: String = "EmptyState"

  override func setUp() {
    sut = PostsTableView()
    dataSource = PostsTableViewDataSource()
    sut?.dataSource = dataSource
    dataSource?.postsTableView = sut
  }

  func testEmptyLayout() {
    dataSource?.posts = []
    snapshotView()
  }

  func testCellsLayout() {
    let creator = User(id: 1,
                       name: "creator",
                       creationTimestamp: Date.testDate.timeIntervalSince1970)
    let post = Post(id: 1,
                    creator: creator,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: "Post content", parentPost: nil)
    let quote = Post(id: 2,
                    creator: creator,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: "Post content", parentPost: post)
    let repost = Post(id: 2,
                      creator: creator,
                      creationTimestamp: Date.testDate.timeIntervalSince1970,
                      content: nil,
                      parentPost: post)
    dataSource?.posts = [post, quote, repost]
    snapshotView()
  }
}
