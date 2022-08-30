//
//  AppDelegate.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 28/08/22.
//

import UIKit
import SQLite

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let sessionService: SessionService & UserLogging = InMemorySessionService()

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()

    createSession()

    return true
  }

  private func createSession() {
    let userService: UserService? = UserSQLService()
    guard let user = userService?.userById(1) else {
      return
    }
    print(sessionService.login(user))
    print(sessionService.user)
  }
}
