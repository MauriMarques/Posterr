//
//  UserSQLServiceTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 30/08/22.
//

import XCTest
@testable import Posterr

class UserSQLServiceTests: XCTestCase {

  var sut: UserSQLService?

  override func setUp() {
    sut = UserSQLService(dbFilename: "posterr_test.db")
  }

  func testInitWithIncorrectDb() {
    sut = UserSQLService(dbFilename: "incorrect.db")
    XCTAssertNil(sut)
  }

  func testGetUserByExistingId() {
    let user = sut?.userById(1)
    XCTAssertNotNil(user)
  }

  func testGetUserByInexistingId() {
    let user = sut?.userById(10)
    XCTAssertNil(user)
  }
}
