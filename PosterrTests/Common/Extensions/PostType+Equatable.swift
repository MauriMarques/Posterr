//
//  PostType+Equatable.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
@testable import Posterr

extension PostType: RawRepresentable {

  public var rawValue: String {
    switch self {
    case .normal:
      return "normal"
    case .quote:
      return "quote"
    case .repost:
      return "repost"
    }
  }

  public typealias RawValue = String

  public init?(rawValue: String) {
    nil
  }
}
