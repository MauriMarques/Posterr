//
//  SnapshotViewTests.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import XCTest
import SnapshotTesting
import UIKit

protocol SnapshotViewTestable {
  associatedtype View
  var sut: View? { get set }
  var containerSize: CGSize { get }
  var record: Bool { get }
  func configTest()
  func snapshotView()
}

extension SnapshotViewTestable {

  func configTest() {
    
  }

  func snapshotView() {
    configTest()
    guard let sut = sut as? UIView else {
      return
    }
    let container = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: containerSize.width,
                                         height: containerSize.height))
    sut.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(sut)
    NSLayoutConstraint.activate([
      sut.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      sut.topAnchor.constraint(equalTo: container.topAnchor),
      sut.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      sut.bottomAnchor.constraint(equalTo: container.bottomAnchor)
    ])
    let className = String(describing: self)
    let result = verifySnapshot(matching: container,
                                as: .image,
                                named: className,
                                record: record)
    XCTAssertNil(result)
  }
}
