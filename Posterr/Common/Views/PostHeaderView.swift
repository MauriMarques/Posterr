//
//  PostHeaderView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

protocol PostHeaderViewModel {
  var creatorUserName: String { get }
  var creationDateString: String { get }
}

final class PostHeaderView: UIView {

  struct AccessibilityIdentifier {
    static let `self` = "post_header_view"
  }

  private lazy var profileBarView: ProfileBarView = {
    let profileBarView = ProfileBarView()
    profileBarView.translatesAutoresizingMaskIntoConstraints = false
    return profileBarView
  }()

  private lazy var contentCreationDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 14.0)
    label.textColor = .gray
    return label
  }()

  init() {
    super.init(frame: .zero)
    setupCodableView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PostHeaderView: ViewModelSettable {
  func setViewModel(_ viewModel: PostHeaderViewModel) {
    profileBarView.userName = viewModel.creatorUserName
    contentCreationDateLabel.text = viewModel.creationDateString
  }
}

extension PostHeaderView: ViewCodable {
  func buildViewHierarchy() {
    addSubview(profileBarView)
    addSubview(contentCreationDateLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      profileBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
      profileBarView.topAnchor.constraint(equalTo: topAnchor),
      profileBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentCreationDateLabel.leadingAnchor.constraint(equalTo: profileBarView.trailingAnchor, constant: 10.0),
      contentCreationDateLabel.centerYAnchor.constraint(equalTo: profileBarView.centerYAnchor)
    ])
  }

  func configureView() {
    accessibilityIdentifier = AccessibilityIdentifier.`self`
  }
}
