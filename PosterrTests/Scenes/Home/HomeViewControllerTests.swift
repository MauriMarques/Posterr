//
//  HomeViewControllerTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import XCTest
import SnapshotTesting
import UIKit
@testable import Posterr

final class HomeViewControllerTests: XCTestCase {

  func testDefaultLayout() {
    let dataSource = PostsTableViewDataSource()
    let creator = User(id: 1,
                       name: "creator",
                       creationTimestamp: Date.testDate.timeIntervalSince1970)
    let post = Post(id: 1,
                    creator: creator,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: "Post content",
                    parentPost: nil)
    let quote = Post(id: 2,
                    creator: creator,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: "Post content",
                    parentPost: post)
    let repost = Post(id: 2,
                      creator: creator,
                      creationTimestamp: Date.testDate.timeIntervalSince1970,
                      content: nil,
                      parentPost: post)
    let sut = HomeViewController(postsTableViewDataSource: dataSource)
    let viewController = UINavigationController(rootViewController: sut)
    dataSource.posts = [post, quote, repost]
    sut.loadUser(creator)
    let result = verifySnapshot(matching: viewController,
                                as: .image(on: .iPhoneX),
                                named: "Default",
                                record: false,
                                testName: "HomeViewController")
    XCTAssertNil(result)
  }
}
