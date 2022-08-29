//
//  InMemorySessionService.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation

final class InMemorySessionService: SessionService & UserLogging {
  var user: User?

  func login(_ user: User) -> Bool {
    self.user = user
    return true
  }
}
