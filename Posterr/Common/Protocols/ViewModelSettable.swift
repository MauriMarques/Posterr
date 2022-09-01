//
//  ViewModelSettable.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation

protocol ViewModelSettable {
  associatedtype ViewModel
  func setViewModel(_ viewModel: ViewModel)
}
