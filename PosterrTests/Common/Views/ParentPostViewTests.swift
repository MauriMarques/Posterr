//
//  ParentPostViewTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

final class ParentPostViewTests: XCTestCase, SnapshotViewTestable {

  var sut: ParentPostView?

  var containerSize: CGSize = CGSize(width: 300, height: 200)

  var record: Bool = false

  override func setUp() {
    sut = ParentPostView()
  }

  func configTest() {
    sut?.setViewModel(ParentPostViewModelMock())
  }

  func testDefaultLayout() {
    snapshotView()
  }
}
