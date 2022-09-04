//
//  CreatePostViewControllerTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
import SnapshotTesting
import UIKit
@testable import Posterr

final class CreatePostViewControllerTests: XCTestCase {

  let creator = User(id: 1,
                     name: "creator",
                     creationTimestamp: Date().timeIntervalSince1970)

  lazy var post = {
    Post(id: 1,
         creator: creator,
         creationTimestamp: Date().timeIntervalSince1970,
         content: "Post content", parentPost: nil)
  }()

  func testNormalPostLayout() {
    let sut = CreatePostViewController(postType: .normal,
                                       appConfig: AppConfigMock())
    let viewController = UINavigationController(rootViewController: sut)
    sut.loadUser(creator)
    let result = verifySnapshot(matching: viewController,
                                as: .image(on: .iPhoneX),
                                named: "NormalPost",
                                record: false,
                                testName: "CreatePostViewController")
    XCTAssertNil(result)
  }

  func testQuotePostLayout() {
    let sut = CreatePostViewController(postType: .quote(post),
                                       appConfig: AppConfigMock())
    let viewController = UINavigationController(rootViewController: sut)
    sut.loadUser(creator)
    let result = verifySnapshot(matching: viewController,
                                as: .image(on: .iPhoneX),
                                named: "QuotePost",
                                record: false,
                                testName: "CreatePostViewController")
    XCTAssertNil(result)
  }

  func testRepostPostLayout() {
    let sut = CreatePostViewController(postType: .repost(post),
                                       appConfig: AppConfigMock())
    let viewController = UINavigationController(rootViewController: sut)
    sut.loadUser(creator)
    let result = verifySnapshot(matching: viewController,
                                as: .image(on: .iPhoneX),
                                named: "RepostPost",
                                record: false,
                                testName: "CreatePostViewController")
    XCTAssertNil(result)
  }
}
