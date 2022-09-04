//
//  ProfileImageViewTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

final class ProfileImageViewTests: XCTestCase, SnapshotViewTestable {

  var sut: ProfileImageView?

  var containerSize: CGSize = CGSize(width: 100, height: 100)

  var record: Bool = false

  override func setUp() {
    sut = ProfileImageView()
  }

  func configTest() {
    sut?.setImageByUserName("ecramDEi")
  }

  func testDefaultLayout() {
    snapshotView()
  }
}
