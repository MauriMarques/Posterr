//
//  ProfileInteractorListenerMock.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

import Foundation
@testable import Posterr

final class ProfileInteractorListenerMock: ProfileInteractableListerner {

  var didCallCloseProfile: Bool = false

  func didCloseProfile() {
    didCallCloseProfile = true
  }
}
