//
//  CreatePostInteractorTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
@testable import Posterr

final class CreatePostInteractorTests: XCTestCase {

  var sut: CreatePostInteractor?
  var appConfig: AppConfigMock!
  var sessionServiceMock: SessionServiceMock!
  var postServiceMock: PostsServiceMock!
  var createPostPresenterSpy: CreatePostPresenterSpy!
  var createPostRouterSpy: CreatePostRouterSpy!
  var createPostInteractorListenerMock: CreatePostInteractorListenerMock!

  override func setUp() {
    appConfig = AppConfigMock()
    sessionServiceMock = SessionServiceMock()
    postServiceMock = PostsServiceMock()
    createPostPresenterSpy = CreatePostPresenterSpy()
    createPostRouterSpy = CreatePostRouterSpy()
    createPostInteractorListenerMock = CreatePostInteractorListenerMock()
    sut = CreatePostInteractor(presenter: createPostPresenterSpy,
                               sessionService: sessionServiceMock,
                               appConfig: appConfig,
                               postService: postServiceMock,
                               postType: .normal)
    sut?.router = createPostRouterSpy
    sut?.listener = createPostInteractorListenerMock
  }

  func testDidLoad() {
    sut?.didLoad()
    XCTAssertEqual(createPostPresenterSpy.loadedUser, sessionServiceMock.user)
  }

  func testLoadUserFail() {
    sessionServiceMock.user = nil
    sut?.didLoad()
    XCTAssertTrue(createPostInteractorListenerMock.didCallCloseCreatePost)
  }

  func testCantCreatePostOnLoad() {
    appConfig.limitOfPostsPerDay = 0
    sut?.didLoad()
    XCTAssertTrue(createPostPresenterSpy.didCallShowPostsCreationLimitReachedAlert)
  }

  func testDidClose() {
    sut?.didCancel()
    XCTAssertTrue(createPostInteractorListenerMock.didCallCloseCreatePost)
  }

  func testCreatePostFail() {
    sessionServiceMock.user = nil
    sut?.didClickOnCreatePost(content: "Post")
    XCTAssertTrue(createPostInteractorListenerMock.didCallCloseCreatePost)
  }

  func testCantCreatePost() {
    appConfig.limitOfPostsPerDay = 0
    sut?.didClickOnCreatePost(content: "Post")
    XCTAssertTrue(createPostPresenterSpy.didCallShowPostsCreationLimitReachedAlert)
  }

  func testCreatePost() {
    guard let user = sessionServiceMock.user else {
      return
    }
    let post = Post(id: 1,
                    creator: user,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: "Post content",
                    parentPost: nil)
    postServiceMock.createdPost = post
    sut?.didClickOnCreatePost(content: "Post")
    XCTAssertEqual(createPostInteractorListenerMock.didCreatePost, post)
  }

  func testCreateQuote() {
    guard let user = sessionServiceMock.user else {
      return
    }
    let parentPost = Post(id: 1,
                    creator: user,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: "Post content",
                    parentPost: nil)
    sut = CreatePostInteractor(presenter: createPostPresenterSpy,
                               sessionService: sessionServiceMock,
                               appConfig: appConfig,
                               postService: postServiceMock,
                               postType: .quote(parentPost))
    sut?.listener = createPostInteractorListenerMock
    let post = Post(id: 2,
                    creator: user,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: "Quote content",
                    parentPost: parentPost)
    postServiceMock.createdPost = post
    sut?.didClickOnCreatePost(content: "Quote")
    XCTAssertEqual(createPostInteractorListenerMock.didCreatePost, post)
  }

  func testRepostPost() {
    guard let user = sessionServiceMock.user else {
      return
    }
    let parentPost = Post(id: 1,
                    creator: user,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: "Post content",
                    parentPost: nil)
    sut = CreatePostInteractor(presenter: createPostPresenterSpy,
                               sessionService: sessionServiceMock,
                               appConfig: appConfig,
                               postService: postServiceMock,
                               postType: .repost(parentPost))
    sut?.listener = createPostInteractorListenerMock
    let post = Post(id: 2,
                    creator: user,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: nil,
                    parentPost: parentPost)
    postServiceMock.createdPost = post
    sut?.didClickOnCreatePost(content: "Repost")
    XCTAssertEqual(createPostInteractorListenerMock.didCreatePost, post)
  }

  func testQuoteQuote() {
    guard let user = sessionServiceMock.user else {
      return
    }
    let parentParentPost = Post(id: 1,
                                creator: user,
                                creationTimestamp: Date.testDate.timeIntervalSince1970,
                                content: "Post content",
                                parentPost: nil)
    let parentPost = Post(id: 2,
                          creator: user,
                          creationTimestamp: Date.testDate.timeIntervalSince1970,
                          content: "Quote content",
                          parentPost: parentParentPost)
    sut = CreatePostInteractor(presenter: createPostPresenterSpy,
                               sessionService: sessionServiceMock,
                               appConfig: appConfig,
                               postService: postServiceMock,
                               postType: .quote(parentPost))
    sut?.listener = createPostInteractorListenerMock
    let post = Post(id: 3,
                          creator: user,
                          creationTimestamp: Date.testDate.timeIntervalSince1970,
                          content: "Quote content",
                          parentPost: parentPost)
    postServiceMock.createdPost = post
    sut?.didClickOnCreatePost(content: "Quote")
    XCTAssertEqual(createPostInteractorListenerMock.didCreatePost, post)
  }

  func testQuoteRepost() {
    guard let user = sessionServiceMock.user else {
      return
    }
    let parentParentPost = Post(id: 1,
                                creator: user,
                                creationTimestamp: Date.testDate.timeIntervalSince1970,
                                content: "Post content",
                                parentPost: nil)
    let parentPost = Post(id: 2,
                          creator: user,
                          creationTimestamp: Date.testDate.timeIntervalSince1970,
                          content: nil,
                          parentPost: parentParentPost)
    sut = CreatePostInteractor(presenter: createPostPresenterSpy,
                               sessionService: sessionServiceMock,
                               appConfig: appConfig,
                               postService: postServiceMock,
                               postType: .quote(parentPost))
    sut?.listener = createPostInteractorListenerMock
    let post = Post(id: 3,
                    creator: user,
                    creationTimestamp: Date.testDate.timeIntervalSince1970,
                    content: "Quote content",
                    parentPost: parentPost)
    postServiceMock.createdPost = post
    sut?.didClickOnCreatePost(content: "Quote")
    XCTAssertEqual(createPostInteractorListenerMock.didCreatePost, post)
  }

  func testRepostQuote() {
    guard let user = sessionServiceMock.user else {
      return
    }
    let parentParentPost = Post(id: 1,
                                creator: user,
                                creationTimestamp: Date.testDate.timeIntervalSince1970,
                                content: "Post content",
                                parentPost: nil)
    let parentPost = Post(id: 2,
                          creator: user,
                          creationTimestamp: Date.testDate.timeIntervalSince1970,
                          content: "Quote content",
                          parentPost: parentParentPost)
    sut = CreatePostInteractor(presenter: createPostPresenterSpy,
                               sessionService: sessionServiceMock,
                               appConfig: appConfig,
                               postService: postServiceMock,
                               postType: .repost(parentPost))
    sut?.listener = createPostInteractorListenerMock
    let post = Post(id: 3,
                          creator: user,
                          creationTimestamp: Date.testDate.timeIntervalSince1970,
                          content: nil,
                          parentPost: parentPost)
    postServiceMock.createdPost = post
    sut?.didClickOnCreatePost(content: "Repost")
    XCTAssertEqual(createPostInteractorListenerMock.didCreatePost, post)
  }

  func testRepostRepost() {
    guard let user = sessionServiceMock.user else {
      return
    }
    let parentParentPost = Post(id: 1,
                                creator: user,
                                creationTimestamp: Date.testDate.timeIntervalSince1970,
                                content: "Post content",
                                parentPost: nil)
    let parentPost = Post(id: 2,
                          creator: user,
                          creationTimestamp: Date.testDate.timeIntervalSince1970,
                          content: nil,
                          parentPost: parentParentPost)
    sut = CreatePostInteractor(presenter: createPostPresenterSpy,
                               sessionService: sessionServiceMock,
                               appConfig: appConfig,
                               postService: postServiceMock,
                               postType: .repost(parentPost))
    sut?.listener = createPostInteractorListenerMock
    let post = Post(id: 3,
                          creator: user,
                          creationTimestamp: Date.testDate.timeIntervalSince1970,
                          content: nil,
                          parentPost: parentPost)
    postServiceMock.createdPost = post
    sut?.didClickOnCreatePost(content: "Repost")
    XCTAssertEqual(createPostInteractorListenerMock.didCreatePost, post)
  }
}
