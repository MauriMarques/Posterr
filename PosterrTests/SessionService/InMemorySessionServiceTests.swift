//
//  InMemorySessionServiceTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 30/08/22.
//

import XCTest
@testable import Posterr

class InMemorySessionServiceTests: XCTestCase {

  var sut: InMemorySessionService?

  override func setUp() {
    sut = InMemorySessionService()
  }

  func testSessionUserWhenInit() {
    XCTAssertNil(sut?.user, "Session user should be nil after init")
  }

  func testLoginUser() {
    let userToLogin = User(id: 1234,
                           name: "Username",
                           creationTimestamp: Date().timeIntervalSince1970)
    _ = sut?.login(userToLogin)
    XCTAssertEqual(sut?.user, userToLogin)
  }
}
