//
//  DatabaseHelper.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 29/08/22.
//

import Foundation

struct DatabaseHelper {

  private(set) var localDbFilename: String?

  init(dbFilename: String) {
    localDbFilename = self.copyDatabaseToDocuments(dbFilename: dbFilename)
  }

  private func copyDatabaseToDocuments(dbFilename: String) -> String? {
    let fileManager = FileManager.default

    guard let documentsUrl = fileManager.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first else {
      return nil
    }

    let finalDatabaseURL = documentsUrl.appendingPathComponent(dbFilename)

    do {
      if !fileManager.fileExists(atPath: finalDatabaseURL.path) {
        if let dbFilePath = Bundle.main.resourceURL?.appendingPathComponent(dbFilename) {
          try fileManager.copyItem(atPath: dbFilePath.path,
                                   toPath: finalDatabaseURL.path)
        } else {
          return nil
        }
      }
      return finalDatabaseURL.path
    } catch {
      return nil
    }
  }
}
