//
//  ProfileUITests.swift
//  PosterrUITests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
@testable import Posterr

final class ProfileUITests: PosterrUITests {

  func testInitialState() {
    app.launch()

    app.otherElements["profile_bar_view"].tap()

    XCTAssert(app.otherElements["profile_header_view"].waitForExistence(timeout: timeout))
    XCTAssert(app.buttons["profile_compose_button"].waitForExistence(timeout: timeout))
  }

  func testTapComposeButton() {
    app.launch()
    app.otherElements["profile_bar_view"].tap()
    app.buttons["profile_compose_button"].tap()
    XCTAssert(app.textViews["content_text_view"].waitForExistence(timeout: timeout))
    XCTAssert(app.buttons["create_button"].waitForExistence(timeout: timeout))
  }
}
