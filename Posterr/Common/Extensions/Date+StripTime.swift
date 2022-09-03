//
//  Date+StripTime.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import Foundation

extension Date {
  func stripTime() -> Date? {
    let components = Calendar.current.dateComponents([
      .year,
      .month,
      .day],
                                                     from: self)
    let date = Calendar.current.date(from: components)
    return date
  }
}
