//
//  UserService.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation

protocol UserService {
  func userById(_ id: Int64) -> User?
}
