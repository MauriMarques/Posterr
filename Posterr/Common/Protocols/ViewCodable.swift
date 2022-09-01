//
//  ViewCodable.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation

protocol ViewCodable {
  func buildViewHierarchy()
  func setupConstraints()
  func configureView()

  func setupCodableView()
}

extension ViewCodable {
  func configureView() {}

  func setupCodableView() {
    self.buildViewHierarchy()
    self.setupConstraints()
    self.configureView()
  }
}
