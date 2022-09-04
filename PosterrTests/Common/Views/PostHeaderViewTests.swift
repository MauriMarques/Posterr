//
//  PostHeaderViewTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

final class PostHeaderViewTests: XCTestCase, SnapshotViewTestable {

  var sut: PostHeaderView?

  var containerSize: CGSize = CGSize(width: 300, height: 80)

  var record: Bool = false

  override func setUp() {
    sut = PostHeaderView()
  }

  func configTest() {
    sut?.setViewModel(PostHeaderViewModelMock())
  }

  func testDefaultLayout() {
    snapshotView()
  }
}
