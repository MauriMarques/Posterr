//
//  SQLDatabaseCleaner.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 30/08/22.
//

import SQLite

struct SQLDatabaseCleaner {

  @discardableResult
  static func clearTable(_ tableName: String) -> Bool {
    do {
      guard let databasePath = DatabaseHelper(dbFilename: "posterr_test.db").localDbFilename else {
        return false
      }
      let testDatabase = try Connection(databasePath)
      try testDatabase.run(Table(tableName).delete())
      return true
    } catch {
      return false
    }
  }
}
