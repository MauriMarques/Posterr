//
//  UserSQLService.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation
import SQLite

struct UserTableFields {
  static let idField = Expression<Int64>("id")
  static let nameField = Expression<String>("name")
  static let creationTimestampField = Expression<TimeInterval>("creation_timestamp")
}

struct UserSQLService: UserService {

  private let database: Connection?

  init?(dbFilename: String) {
    do {
      guard let databasePath = DatabaseHelper(dbFilename: dbFilename).localDbFilename else {
        return nil
      }
      database = try Connection(databasePath)
    } catch {
      return nil
    }
  }

  func userById(_ userId: Int64) -> User? {
    guard let database = database else {
      return nil
    }

    let userTable = Table("User")

    let userQuery = userTable.filter(UserTableFields.idField == userId)
    do {
      guard let userRegister = try database.pluck(userQuery) else {
        return nil
      }
      return User(id: userRegister[UserTableFields.idField],
                  name: userRegister[UserTableFields.nameField],
                  creationTimestamp: userRegister[UserTableFields.creationTimestampField])
    } catch {
      return nil
    }
  }
}
