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
  private let appConfig = AppConfig(configFilename: "PosterrAppConfig")
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
    guard appConfig.loggedUserId > -1,
          let user = userService?.userById(appConfig.loggedUserId) else {
      return
    }
    _ = sessionService.login(user)
  }

  private func launchHome() {
    let postService = PostSQLService(appConfig: appConfig)
    guard let window = window,
          let postService = postService else {
            return
          }
    let homeRouter = HomeBuilder(appConfig: appConfig).build(sessionService: sessionService,
                                                             postService: postService)
    self.homeRouter = homeRouter
    homeRouter.launch(from: window)
  }
}
