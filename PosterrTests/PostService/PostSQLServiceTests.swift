//
//  PostSQLServiceTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 30/08/22.
//

import XCTest
@testable import Posterr

class PostSQLServiceTests: XCTestCase {

  var sut: PostSQLService?
  var appConfig = AppConfigMock()

  override func setUp() {
    sut = PostSQLService(dbFilename: "posterr_test.db",
                         appConfig: appConfig)
  }

  override func tearDown() {
    SQLDatabaseCleaner.clearTable("Post")
  }

  func testInitWithIncorrectDb() {
    sut = PostSQLService(dbFilename: "incorrect.db",
                         appConfig: appConfig)
    XCTAssertNil(sut)
  }

  func testCreatePost() {
    createPost()
  }

  func testCreatePostBiggerThanMaxLength() {
    let creator = User(id: 1,
                       name: "ecramDEi",
                       creationTimestamp: TimeInterval(1619205684.79362))
    let createdPost = sut?.createPost(content: """
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
""",
                                      creator: creator)
    XCTAssertNil(createdPost, "Posts with content bigger than \(appConfig.postMaxLegnth) characters should not be created")
  }

  func testRepostPost() {
    guard let parentPost = createPost() else {
      XCTFail("A repost can not be made without a parent post")
      return
    }
    let repostCreator = User(id: 3,
                             name: "StRioviT",
                             creationTimestamp: TimeInterval(1605720084.79362))
    let repost = sut?.repostPost(parentPost: parentPost,
                                 creator: repostCreator)
    XCTAssertEqual(repost?.parentPost, parentPost)
    XCTAssertEqual(repost?.creator, repostCreator)
    XCTAssertEqual(repost?.type, .repost)

    let posts = sut?.allPosts()
    XCTAssertEqual(posts?.count, 2)
    XCTAssertEqual(posts?.first, repost)
  }

  func testQuotePost() {
    guard let parentPost = createPost() else {
      XCTFail("A quote can not be made without a parent post")
      return
    }
    let quoteCreator = User(id: 2,
                             name: "WairLeXt",
                             creationTimestamp: TimeInterval(1560273684.79362))
    let quoteContent = "A really nice quote"
    let quote = sut?.quotePost(content: quoteContent,
                                parentPost: parentPost,
                                creator: quoteCreator)
    XCTAssertEqual(quote?.content, quoteContent)
    XCTAssertEqual(quote?.parentPost, parentPost)
    XCTAssertEqual(quote?.creator, quoteCreator)
    XCTAssertEqual(quote?.type, .quote)

    let posts = sut?.allPosts()
    XCTAssertEqual(posts?.count, 2)
    XCTAssertEqual(posts?.first, quote)
  }

  @discardableResult
  private func createPost() -> Post? {
    let creator = User(id: 1,
                       name: "ecramDEi",
                       creationTimestamp: TimeInterval(1619205684.79362))
    let content = "Test content"
    let createdPost = sut?.createPost(content: content,
                                      creator: creator)
    XCTAssertEqual(createdPost?.content, content)
    XCTAssertEqual(createdPost?.creator, creator)
    XCTAssertEqual(createdPost?.type, .normal)

    let posts = sut?.allPosts()
    XCTAssertEqual(posts?.count, 1)
    XCTAssertEqual(posts?.first, createdPost)
    return createdPost
  }
}
