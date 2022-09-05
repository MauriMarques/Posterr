//
//  SessionServiceMock.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
@testable import Posterr

final class SessionServiceMock: SessionService {
  var user: User? = User(id: 1234,
                         name: "Username",
                         creationTimestamp: Date.testDate.timeIntervalSince1970)
}
