//
//  PostSQLService.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation
import SQLite

struct PostTableFields {
  static let idField = Expression<Int64>("id")
  static let creatorIdField = Expression<Int64>("creator_id")
  static let creationTimestampField = Expression<TimeInterval>("post_creation_timestamp")
  static let contentField = Expression<String?>("content")
  static let parentPostIdField = Expression<Int64?>("parent_post_id")
}

struct PostSQLService: PostService {

  private let database: Connection?
  private let appConfig: PosterrAppConfig

  init?(dbFilename: String, appConfig: PosterrAppConfig) {
    self.appConfig = appConfig
    do {
      guard let databasePath = DatabaseHelper(dbFilename: dbFilename).localDbFilename else {
        return nil
      }
      database = try Connection(databasePath)
    } catch {
      return nil
    }
  }

  func allPosts() -> [Post] {
    searchPosts(by: Table("Post"))
  }

  func postsByCreator(_ creator: User, onDate date: Date?) -> [Post] {
    if let date = date {
      return searchPosts(by: Table("Post").filter(PostTableFields.creatorIdField == creator.id && PostTableFields.creationTimestampField >= date.timeIntervalSince1970))
    } else {
      return searchPosts(by: Table("Post").filter(PostTableFields.creatorIdField == creator.id))
    }
  }

  func createPost(content: String, creator: User) -> Post? {
    registerPost(content: content,
                 creator: creator)
  }

  func repostPost(parentPost: Post, creator: User) -> Post? {
    registerPost(parentPost: parentPost,
                 creator: creator)
  }

  func quotePost(content: String, parentPost: Post, creator: User) -> Post? {
    registerPost(content: content,
                 parentPost: parentPost,
                 creator: creator)
  }

  private func registerPost(content: String? = nil, parentPost: Post? = nil, creator: User) -> Post? {
    guard let database = database else {
      return nil
    }

    if let content = content,
        content.count > appConfig.postMaxLegnth {
      return nil
    }

    let postTable = Table("Post")

    do {
      let creationTimestamp = Date().timeIntervalSince1970
      let insert: Insert
      if let parentPost = parentPost {
        if let content = content {
          insert = postTable.insert(PostTableFields.creatorIdField <- creator.id,
                                    PostTableFields.creationTimestampField <- creationTimestamp,
                                    PostTableFields.contentField <- content,
                                    PostTableFields.parentPostIdField <- parentPost.id)
        } else {
          insert = postTable.insert(PostTableFields.creatorIdField <- creator.id,
                                    PostTableFields.creationTimestampField <- creationTimestamp,
                                    PostTableFields.parentPostIdField <- parentPost.id)
        }
      } else {
        insert = postTable.insert(PostTableFields.creatorIdField <- creator.id,
                                  PostTableFields.creationTimestampField <- creationTimestamp,
                                  PostTableFields.contentField <- content)
      }
      let rowId = try database.run(insert)
      return Post(id: rowId,
                  creator: creator,
                  creationTimestamp: TimeInterval(creationTimestamp),
                  content: content,
                  parentPost: parentPost)
    } catch {
      return nil
    }
  }

  private func searchPosts(by postTable: Table) -> [Post] {
    guard let database = database else {
      return []
    }

    let userTable = Table("User")

    do {
      let postJoinQuery = postTable.join(userTable,
                                         on: userTable[UserTableFields.idField] == postTable[PostTableFields.creatorIdField])
        .order(postTable[PostTableFields.creationTimestampField].desc)
      return (try database.prepare(postJoinQuery)).compactMap { postRegister in
        let creator = User(id: postRegister[userTable[UserTableFields.idField]],
                           name: postRegister[UserTableFields.nameField],
                           creationTimestamp: TimeInterval(postRegister[userTable[UserTableFields.creationTimestampField]]))

        var parentPost: Post?
        let noFieltrsPostTable = Table("Post")
        if let parentPostId = postRegister[postTable[PostTableFields.parentPostIdField]] {
          let parentPostQuery = noFieltrsPostTable.filter(noFieltrsPostTable[PostTableFields.idField] == parentPostId)
            .join(userTable, on: userTable[UserTableFields.idField] == noFieltrsPostTable[PostTableFields.creatorIdField])

          if let parentPostRegister = try? database.pluck(parentPostQuery) {
            let creationTimestamp = TimeInterval(parentPostRegister[userTable[UserTableFields.creationTimestampField]])
            let parentPostCreator = User(id: parentPostRegister[userTable[UserTableFields.idField]],
                                         name: parentPostRegister[UserTableFields.nameField],
                                         creationTimestamp: creationTimestamp)
            parentPost = Post(id: parentPostId,
                              creator: parentPostCreator,
                              creationTimestamp: TimeInterval(parentPostRegister[noFieltrsPostTable[PostTableFields.creationTimestampField]]),
                              content: parentPostRegister[noFieltrsPostTable[PostTableFields.contentField]],
                              parentPost: nil)
          }
        }

        let post = Post(id: postRegister[postTable[PostTableFields.idField]],
                        creator: creator,
                        creationTimestamp: TimeInterval(postRegister[postTable[PostTableFields.creationTimestampField]]),
                        content: postRegister[postTable[PostTableFields.contentField]],
                        parentPost: parentPost)
        return post
      }
    } catch {
      print(error)
      return []
    }
  }
}
