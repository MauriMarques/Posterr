//
//  AppConfigMock.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import Foundation
@testable import Posterr

final class AppConfigMock: PosterrAppConfig {
  var postMaxLegnth: Int = 777

  var limitOfPostsPerDay: Int = 5

  var loggedUserId: Int64 = 1
}
