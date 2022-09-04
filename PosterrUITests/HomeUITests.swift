//
//  HomeUITests.swift
//  PosterrUITests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
@testable import Posterr

class PosterrUITests: XCTestCase {

  let app = XCUIApplication()

  let timeout: TimeInterval = 15.0

  override func setUp() {
    app.launchArguments.append("CLEAR_DB")
  }
}

final class HomeUITests: PosterrUITests {

  func testInitialState() {
    app.launch()

    XCTAssert(app.staticTexts["empty_label"].waitForExistence(timeout: timeout))
    XCTAssert(app.buttons["home_compose_button"].waitForExistence(timeout: timeout))
  }

  func testTapComposeButton() {
    app.launch()
    app.buttons["home_compose_button"].tap()
    XCTAssert(app.textFields["content_text_field"].waitForExistence(timeout: timeout))
    XCTAssert(app.buttons["create_button"].waitForExistence(timeout: timeout))
  }
}
