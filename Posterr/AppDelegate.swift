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
  private var dbFilename: String {
    #if UITesting
    "posterr_test.db"
    #else
    "posterr.db"
    #endif
  }

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    createSession()

    #if UITesting
    setUpTestData()
    #endif

    launchHome()
    return true
  }

  private func createSession() {
    let userService: UserService? = UserSQLService(dbFilename: dbFilename)
    guard appConfig.loggedUserId > -1,
          let user = userService?.userById(appConfig.loggedUserId) else {
      return
    }
    _ = sessionService.login(user)
  }

  private func launchHome() {
    let postService = PostSQLService(dbFilename: dbFilename,
                                     appConfig: appConfig)
    guard let window = window,
          let postService = postService else {
            return
          }
    let homeRouter = HomeBuilder(appConfig: appConfig).build(sessionService: sessionService,
                                                             postService: postService)
    self.homeRouter = homeRouter
    homeRouter.launch(from: window)
  }

  #if UITesting
  private func setUpTestData() {
    if ProcessInfo.processInfo.arguments.contains("CLEAR_DB") {
      SQLDatabaseCleaner.clearTable("Post")
    }

    if ProcessInfo.processInfo.arguments.contains("ONE_POST") {
      guard let user = sessionService.user,
            let postService = PostSQLService(dbFilename: dbFilename,
                                             appConfig: appConfig) else {
              return
            }
      _ = postService.createPost(content: "My first post!",
                                 creator: user)
    }

    if ProcessInfo.processInfo.arguments.contains("ONE_QUOTE_POST") {
      guard let user = sessionService.user,
            let postService = PostSQLService(dbFilename: dbFilename,
                                             appConfig: appConfig),
              let post = postService.createPost(content: "My first post!",
                                                                                                      creator: user) else {
              return
            }

      _ = postService.quotePost(content: "Greate post!",
                                        parentPost: post,
                                        creator: user)
    }

    if ProcessInfo.processInfo.arguments.contains("ONE_REPOST") {
      guard let user = sessionService.user,
            let postService = PostSQLService(dbFilename: dbFilename,
                                             appConfig: appConfig),
            let post = postService.createPost(content: "My first post!",
                                              creator: user) else {
              return
            }

      _ = postService.repostPost(parentPost: post,
                                 creator: user)
    }

    if ProcessInfo.processInfo.arguments.contains("POSTS_LIMIT_REACHED") {
      guard let user = sessionService.user,
            let postService = PostSQLService(dbFilename: dbFilename,
                                             appConfig: appConfig) else {
              return
            }
      for counter in 0..<appConfig.limitOfPostsPerDay {
        _ = postService.createPost(content: "\(counter) post!",
                                   creator: user)
      }
    }
  }
  #endif
}
