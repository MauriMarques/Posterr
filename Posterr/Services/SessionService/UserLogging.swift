//
//  UserLogging.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation

protocol UserLogging {
  func login(_ user: User) -> Bool
}
