//
//  HomeBuilderTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
@testable import Posterr

final class HomeBuilderTests: XCTestCase {

  var sut: HomeBuilder?

  override func setUp() {
    sut = HomeBuilder(sessionService: SessionServiceMock(),
                      postService: PostsServiceMock(),
                      appConfig: AppConfigMock())
  }

  func testBuild() {
    let homeRouter = sut?.build()
    XCTAssertNotNil(homeRouter)
    XCTAssertTrue(homeRouter is HomeRouter)
  }
}

