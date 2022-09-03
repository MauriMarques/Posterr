//
//  AppConfig.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import Foundation

protocol PosterrAppConfig {
  var postMaxLegnth: Int { get }
  var limitOfPostsPerDay: Int { get }
  var loggedUserId: Int64 { get }
}

struct AppConfig {

  private let configs: [String: Any]?

  init(configFilename: String) {
    var nsDictionary: NSDictionary?
    if let path = Bundle.main.path(forResource: configFilename,
                                   ofType: "plist") {
      nsDictionary = NSDictionary(contentsOfFile: path)
    }
    self.configs = nsDictionary as? [String: Any]
  }
}

extension AppConfig: PosterrAppConfig {
  var postMaxLegnth: Int {
    configs?["POST_MAX_LENGTH"] as? Int ?? 777
  }

  var limitOfPostsPerDay: Int {
    configs?["LIMIT_OF_POSTS_PER_DAY"] as? Int ?? 5
  }

  var loggedUserId: Int64 {
    guard let users = configs?["USERS"] as? [String: [String: Any]] else {
      return -1
    }
    let user = users.first { ($1["IS_LOGGED"] as? Bool) == true }
    return user?.value["ID"] as? Int64
    ?? -1
  }
}
