//
//  ProfileImageView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

class ProfileImageView: UIImageView {

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.borderWidth = 3
    layer.borderColor = UIColor.black.cgColor
    layer.cornerRadius = (frame.width / 2)
    layer.masksToBounds = true
  }

  func setImageByUserName(_ userName: String) {
    guard userName.count >= 2 else {
      return
    }
    let attributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 24.0)
    ]
    let shortUserName = String(userName.prefix(1).capitalized + userName.suffix(1).capitalized)
    image = shortUserName.image(withAttributes: attributes)
    contentMode = .scaleAspectFit
  }
}
