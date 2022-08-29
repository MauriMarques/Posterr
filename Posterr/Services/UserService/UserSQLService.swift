//
//  UserSQLService.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation
import SQLite

struct UserSQLService: UserService {

  private let database: Connection?

  private let userTable = Table("User")
  private let idField = Expression<Int>("id")
  private let nameField = Expression<String>("name")

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

  func userById(_ userId: Int) -> User? {
    guard let database = database else {
      return nil
    }

    let userQuery = userTable.filter(idField == userId)
    do {
      guard let userRegister = try database.pluck(userQuery) else {
        return nil
      }
      return User(id: userRegister[idField],
                  name: userRegister[nameField])
    } catch {
      return nil
    }
  }
}
