//
//  CellIdentifiable.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

protocol CellIdentifiable {
  static var identifier: String { get }
}

extension CellIdentifiable where Self: UITableViewCell {
  static var identifier: String {
    String(describing: self)
  }
}

extension UITableViewCell: CellIdentifiable {}
