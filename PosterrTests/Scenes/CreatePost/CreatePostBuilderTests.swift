//
//  CreatePostBuilderTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
@testable import Posterr

final class CreatePostBuilderTests: XCTestCase {

  var sut: CreatePostBuilder?

  override func setUp() {
    sut = CreatePostBuilder(sessionService: SessionServiceMock(),
                            appConfig: AppConfigMock(),
                            postService: PostsServiceMock())
  }

  func testBuild() {
    let createPostRouter = sut?.build(postType: .normal,
                                listener: nil)
    XCTAssertNotNil(createPostRouter)
    XCTAssertTrue(createPostRouter is CreatePostRouter)
  }
}
