//
//  ProfileInteractorTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
@testable import Posterr

final class ProfileInteractorTests: XCTestCase {

  var sut: ProfileInteractor?
  var sessionServiceMock: SessionServiceMock!
  var postServiceMock: PostsServiceMock!
  var profilePresenterSpy: ProfilePresenterSpy!
  var profileRouterSpy: ProfileRouterSpy!
  var profileInteractorListenerMock: ProfileInteractorListenerMock!

  override func setUp() {
    sessionServiceMock = SessionServiceMock()
    postServiceMock = PostsServiceMock()
    profilePresenterSpy = ProfilePresenterSpy()
    profileRouterSpy = ProfileRouterSpy()
    profileInteractorListenerMock = ProfileInteractorListenerMock()
    sut = ProfileInteractor(presenter: profilePresenterSpy,
                            sessionService: sessionServiceMock,
                            postService: postServiceMock)
    sut?.router = profileRouterSpy
    sut?.listener = profileInteractorListenerMock
  }

  func testDidLoad() {
    postServiceMock.posts = []
    sut?.didLoad()
    XCTAssertEqual(profilePresenterSpy.loadedUser, sessionServiceMock.user)
    XCTAssertEqual(profilePresenterSpy.loadedPosts, postServiceMock.posts)
  }

  func testLoadUserFail() {
    sessionServiceMock.user = nil
    sut?.didLoad()
    XCTAssertNil(profilePresenterSpy.loadedUser)
  }

  func testReloadProfile() {
    postServiceMock.posts = []
    sut?.reloadProfile()
    XCTAssertEqual(profilePresenterSpy.loadedUser, sessionServiceMock.user)
    XCTAssertEqual(profilePresenterSpy.loadedPosts, postServiceMock.posts)
  }

  func testDidClickOnCreatePost() {
    sut?.didClickOnCreatePost()
    XCTAssertTrue(profileRouterSpy.didCallRouterToCreatePost)
  }

  func testDidCancel() {
    sut?.didCancel()
    XCTAssertTrue(profileInteractorListenerMock.didCallCloseProfile)
  }
}
