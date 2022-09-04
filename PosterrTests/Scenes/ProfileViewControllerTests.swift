//
//  ProfileViewControllerTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
import SnapshotTesting
import UIKit
@testable import Posterr

final class ProfileViewControllerTests: XCTestCase {

  func testDefaultLayout() {
    let dataSource = PostsTableViewDataSource()
    let creator = User(id: 1,
                       name: "creator",
                       creationTimestamp: Date().timeIntervalSince1970)
    let post = Post(id: 1,
                    creator: creator,
                    creationTimestamp: Date().timeIntervalSince1970,
                    content: "Post content",
                    parentPost: nil)
    let quote = Post(id: 2,
                    creator: creator,
                    creationTimestamp: Date().timeIntervalSince1970,
                    content: "Post content",
                    parentPost: post)
    let repost = Post(id: 2,
                      creator: creator,
                      creationTimestamp: Date().timeIntervalSince1970,
                      content: nil,
                      parentPost: post)
    let sut = ProfileViewController(postsTableViewDataSource: dataSource)
    let viewController = UINavigationController(rootViewController: sut)
    sut.loadUser(creator)
    sut.loadPosts([post, quote, repost])
    let result = verifySnapshot(matching: viewController,
                                as: .image(on: .iPhoneX),
                                named: "Default",
                                record: false,
                                testName: "ProfileViewController")
    XCTAssertNil(result)
  }
}
