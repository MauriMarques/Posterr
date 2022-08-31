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

  private let sessionService: SessionService & UserLogging = InMemorySessionService()

  private var homeRouter: HomeRouting?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    createSession()
    launchHome()
    return true
  }

  private func createSession() {
    let userService: UserService? = UserSQLService()
    guard let user = userService?.userById(1) else {
      return
    }
    _ = sessionService.login(user)
  }

  private func launchHome() {
    let postService = PostSQLService()
    guard let window = window,
          let postService = postService else {
            return
          }
    let homeRouter = HomeBuilder().build(sessionService: sessionService,
                                         postService: postService)
    self.homeRouter = homeRouter
    homeRouter.launch(from: window)
  }
}
