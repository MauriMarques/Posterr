//
//  ProfileBarView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

protocol ProfileBarViewDelegate: AnyObject {
  func didTapProfileBarView(_ profileBarView: ProfileBarView)
}

class ProfileBarView: UIView {

  struct AccessibilityIdentifier {
    static let `self` = "profile_bar_view"
  }

  var userName: String? {
    didSet {
      guard let userName = userName else {
        return
      }
      userNameLabel.text = userName
      profileImage.setImageByUserName(userName)
    }
  }

  weak var delegate: ProfileBarViewDelegate?

  private lazy var profileImage: ProfileImageView = {
    let imageView = ProfileImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private lazy var userNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = .boldSystemFont(ofSize: 17.0)
    return label
  }()

  init() {
    super.init(frame: .zero)
    self.setupCodableView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc
  private func didTapView() {
    delegate?.didTapProfileBarView(self)
  }
}

extension ProfileBarView: ViewCodable {

  func buildViewHierarchy() {
    addSubview(profileImage)
    addSubview(userNameLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      profileImage.leftAnchor.constraint(equalTo: self.leftAnchor),
      profileImage.topAnchor.constraint(equalTo: self.topAnchor),
      profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
      userNameLabel.leadingAnchor.constraint(equalTo: self.profileImage.trailingAnchor, constant: 5),
      userNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
      userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      userNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }

  func configureView() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
    addGestureRecognizer(tapGesture)
    accessibilityIdentifier = AccessibilityIdentifier.`self`
  }
}
