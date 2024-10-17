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

extension User: Equatable {}
