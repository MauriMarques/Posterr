//
//  User.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation

struct User {
  let id: Int64
  let name: String
  let creationTimestamp: TimeInterval
}

extension User: Equatable {
  static func == (lhs: Self, rhs: Self) -> Bool {
    (lhs.id == rhs.id && lhs.name == rhs.name && lhs.creationTimestamp == rhs.creationTimestamp)
  }
}
