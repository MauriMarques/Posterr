//
//  Date+TestDate.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 05/09/22.
//

import Foundation

extension Date {

  static var testDate: Date {
    let stringDate = "2020-11-11"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: stringDate) ?? Date()
  }
}
