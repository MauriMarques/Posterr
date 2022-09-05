//
//  CreatePostUITests.swift
//  PosterrUITests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import XCTest
@testable import Posterr

final class CreatePostUITests: PosterrUITests {

  func testCreateFirstPost() {
    app.launch()

    let postContent = "My first post!"

    app.buttons["home_compose_button"].tap()
    app.textViews["content_text_view"].typeText(postContent)
    app.buttons["create_button"].tap()

    XCTAssert(app.tables.cells.element(matching: .cell,
                                       identifier: "post_cell").waitForExistence(timeout: timeout))
    XCTAssert(app.staticTexts[postContent].waitForExistence(timeout: timeout))
  }

  func testCreatePostFromProfileScreen() {
    app.launch()

    let postContent = "My first post!"

    app.otherElements["profile_bar_view"].tap()
    app.buttons["profile_compose_button"].tap()
    app.textViews["content_text_view"].typeText(postContent)
    app.buttons["create_button"].tap()

    XCTAssert(app.tables.cells.element(matching: .cell,
                                       identifier: "post_cell").waitForExistence(timeout: timeout))
    XCTAssert(app.staticTexts[postContent].waitForExistence(timeout: timeout))
  }

  func testCancelPostCreation() {
    app.launch()
    app.buttons["home_compose_button"].tap()
    app.buttons["Cancel"].tap()
    XCTAssert(app.staticTexts["empty_label"].waitForExistence(timeout: timeout))
  }

  func testReachPostMaxLength() {
    app.launch()

    app.buttons["home_compose_button"].tap()
    UIPasteboard.general.string = """
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
"""
    app.textViews["content_text_view"].doubleTap()
    app.menuItems["Paste"].tap()
    XCTAssertFalse(app.buttons["create_button"].isEnabled)
  }

  func testReachPostsLimitPerDay() {
    app.launchArguments.append("POSTS_LIMIT_REACHED")
    app.launch()

    app.buttons["home_compose_button"].tap()
    XCTAssert(app.staticTexts["Too many posts for today"].waitForExistence(timeout: timeout))
    XCTAssert(app.staticTexts["Sorry, you have reached the 4 posts per day limit. But no worries, you can continue by tomorrow."].waitForExistence(timeout: timeout))
    XCTAssert(app.buttons["Ok"].waitForExistence(timeout: timeout))
  }

  func testCreateQuote() {
    app.launchArguments.append("ONE_POST")
    app.launch()

    let quoteContent = "Great post!"

    app.tables.cells.element(matching: .cell,
                             identifier: "post_cell").tap()

    app.buttons["Quote"].tap()
    app.textViews["content_text_view"].typeText(quoteContent)

    XCTAssert(app.otherElements["parent_post_view"].waitForExistence(timeout: timeout))

    app.buttons["create_button"].tap()

    XCTAssert(app.tables.cells.element(matching: .cell,
                                       identifier: "quote_cell").waitForExistence(timeout: timeout))
    XCTAssert(app.staticTexts[quoteContent].waitForExistence(timeout: timeout))
  }

  func testRepostPost() {
    app.launchArguments.append("ONE_POST")
    app.launch()

    app.tables.cells.element(matching: .cell,
                             identifier: "post_cell").tap()

    app.buttons["Repost"].tap()

    XCTAssert(app.otherElements["parent_post_view"].waitForExistence(timeout: timeout))

    let createButton = app.buttons["create_button"]

    if createButton.waitForExistence(timeout: timeout) {
      createButton.tap()
    }

    XCTAssert(app.tables.cells.element(matching: .cell,
                                       identifier: "repost_cell").waitForExistence(timeout: timeout))
  }

  func testQuoteQuote() {
    app.launchArguments.append("ONE_QUOTE_POST")
    app.launch()

    let quoteContent = "Great great post!"

    app.tables.cells.element(matching: .cell,
                             identifier: "quote_cell").tap()

    app.buttons["Quote"].tap()

    XCTAssert(app.otherElements["parent_post_view"].waitForExistence(timeout: timeout))

    app.textViews["content_text_view"].typeText(quoteContent)
    app.buttons["create_button"].tap()

    for _ in 0..<2 {
      XCTAssert(app.tables.cells.element(matching: .cell,
                                         identifier: "quote_cell").waitForExistence(timeout: timeout))
    }
    XCTAssert(app.staticTexts[quoteContent].waitForExistence(timeout: timeout))
  }

  func testRepostQuote() {
    app.launchArguments.append("ONE_QUOTE_POST")
    app.launch()

    app.tables.cells.element(matching: .cell,
                             identifier: "quote_cell").tap()

    app.buttons["Repost"].tap()

    XCTAssert(app.otherElements["parent_post_view"].waitForExistence(timeout: timeout))

    let createButton = app.buttons["create_button"]

    if createButton.waitForExistence(timeout: timeout) {
      createButton.tap()
    }

    XCTAssert(app.tables.cells.element(matching: .cell,
                                       identifier: "repost_cell").waitForExistence(timeout: timeout))
  }

  func testQuoteRepost() {
    app.launchArguments.append("ONE_REPOST")
    app.launch()

    let quoteContent = "I'm reposting this!"

    app.tables.cells.element(matching: .cell,
                             identifier: "repost_cell").tap()

    app.buttons["Quote"].tap()

    XCTAssert(app.otherElements["parent_post_view"].waitForExistence(timeout: timeout))

    app.textViews["content_text_view"].typeText(quoteContent)
    app.buttons["create_button"].tap()

    XCTAssert(app.tables.cells.element(matching: .cell,
                                       identifier: "quote_cell").waitForExistence(timeout: timeout))
    XCTAssert(app.staticTexts[quoteContent].waitForExistence(timeout: timeout))
  }

  func testRepostRepost() {
    app.launchArguments.append("ONE_REPOST")
    app.launch()

    app.tables.cells.element(matching: .cell,
                             identifier: "repost_cell").tap()

    app.buttons["Repost"].tap()

    XCTAssert(app.otherElements["parent_post_view"].waitForExistence(timeout: timeout))

    let createButton = app.buttons["create_button"]

    if createButton.waitForExistence(timeout: timeout) {
      createButton.tap()
    }

    for _ in 0..<2 {
      XCTAssert(app.tables.cells.element(matching: .cell,
                                         identifier: "repost_cell").waitForExistence(timeout: timeout))
    }
  }
}
