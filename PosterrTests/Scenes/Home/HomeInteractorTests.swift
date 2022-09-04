//
//  HomeInteractorTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
@testable import Posterr

final class HomeInteractorTests: XCTestCase {

  var sut: HomeInteractor?
  var sessionServiceMock: SessionServiceMock!
  var postServiceMock: PostsServiceMock!
  var homePresenterSpy: HomePresenterSpy!
  var homeRouterSpy: HomeRouterSpy!

  override func setUp() {
    sessionServiceMock = SessionServiceMock()
    postServiceMock = PostsServiceMock()
    homePresenterSpy = HomePresenterSpy()
    homeRouterSpy = HomeRouterSpy()
    sut = HomeInteractor(presenter: homePresenterSpy,
                         sessionService: sessionServiceMock,
                         postService: postServiceMock)
    sut?.router = homeRouterSpy
  }

  func testDidLoad() {
    postServiceMock.posts = []
    sut?.didLoad()
    XCTAssertEqual(homePresenterSpy.loadedUser, sessionServiceMock.user)
    XCTAssertEqual(homePresenterSpy.loadedPosts, postServiceMock.posts)
  }

  func testLoadUserFail() {
    sessionServiceMock.user = nil
    sut?.didLoad()
    XCTAssertNil(homePresenterSpy.loadedUser)
  }

  func testReloadHome() {
    postServiceMock.posts = []
    sut?.reloadHome()
    XCTAssertEqual(homePresenterSpy.loadedUser, sessionServiceMock.user)
    XCTAssertEqual(homePresenterSpy.loadedPosts, postServiceMock.posts)
  }

  func testDidClickOnCreatePost() {
    sut?.didClickOnCreatePost()
    XCTAssertEqual(homeRouterSpy.didCreatePostType?.rawValue, PostType.normal.rawValue)
  }

  func testDidClickOnQuotePost() {
    guard let user = sessionServiceMock.user else {
      return
    }
    let post = Post(id: 1,
                    creator: user,
                    creationTimestamp: Date().timeIntervalSince1970,
                    content: "Post",
                    parentPost: nil)
    sut?.didClickOnQuotePost(post)
    XCTAssertEqual(homeRouterSpy.didCreatePostType?.rawValue, PostType.quote(post).rawValue)
  }

  func testDidClickOnRepostPost() {
    guard let user = sessionServiceMock.user else {
      return
    }
    let post = Post(id: 1,
                    creator: user,
                    creationTimestamp: Date().timeIntervalSince1970,
                    content: "Post",
                    parentPost: nil)
    sut?.didClickOnRepostPost(post)
    XCTAssertEqual(homeRouterSpy.didCreatePostType?.rawValue, PostType.repost(post).rawValue)
  }

  func testDidClickOnProfileSection() {
    sut?.didClickOnProfileSection()
    XCTAssertTrue(homeRouterSpy.didCallProfile)
  }
}

