//
//  ProfileBuilderTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
@testable import Posterr

final class ProfileBuilderTests: XCTestCase {

  var sut: ProfileBuilder?

  override func setUp() {
    sut = ProfileBuilder(sessionService: SessionServiceMock(),
                         appConfig: AppConfigMock(),
                         postService: PostsServiceMock())
  }

  func testBuild() {
    let profileRouter = sut?.build(listener: nil)
    XCTAssertNotNil(profileRouter)
    XCTAssertTrue(profileRouter is ProfileRouter)
  }
}
