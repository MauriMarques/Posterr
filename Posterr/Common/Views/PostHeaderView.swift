//
//  PostHeaderView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

protocol PostHeaderViewViewModel {
  var creatorUserName: String { get }
  var creationDateString: String { get }
}

class PostHeaderView: UIView {

  lazy var profileBarView: ProfileBarView = {
    let profileBarView = ProfileBarView()
    profileBarView.translatesAutoresizingMaskIntoConstraints = false
    return profileBarView
  }()

  lazy var contentCreationLabel: UILabel = {
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
  func setViewModel(_ viewModel: PostHeaderViewViewModel) {
    profileBarView.userName = viewModel.creatorUserName
    contentCreationLabel.text = viewModel.creationDateString
  }
}

extension PostHeaderView: ViewCodable {
  func buildViewHierarchy() {
    addSubview(profileBarView)
    addSubview(contentCreationLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      profileBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
      profileBarView.topAnchor.constraint(equalTo: topAnchor),
      profileBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentCreationLabel.leadingAnchor.constraint(equalTo: profileBarView.trailingAnchor, constant: 10.0),
      contentCreationLabel.centerYAnchor.constraint(equalTo: profileBarView.centerYAnchor)
    ])
  }  
}
