//
//  ProfileHeaderView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 03/09/22.
//

import Foundation
import UIKit

protocol ProfileHeaderViewModel {
  var userName: String { get }
  var accountCreationDateString: String { get }
  var createdPostsCount: Int { get }
  var createdQuotesCount: Int { get }
  var createdRepostsCount: Int { get }
}

final class ProfileHeaderView: UIView {

  struct AccessibilityIdentifier {
    static let `self` = "profile_header_view"
  }

  private lazy var profileImageView: ProfileImageView = {
    let profileImageView = ProfileImageView()
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    return profileImageView
  }()

  private lazy var userNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = .boldSystemFont(ofSize: 24.0)
    return label
  }()

  private lazy var accountInfoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .equalSpacing
    stackView.axis = .horizontal
    stackView.spacing = 10.0
    return stackView
  }()

  private lazy var accountCreationDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 12.0)
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

extension ProfileHeaderView: ViewModelSettable {
  func setViewModel(_ viewModel: ProfileHeaderViewModel) {
    profileImageView.setImageByUserName(viewModel.userName)
    userNameLabel.text = viewModel.userName

    accountInfoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    let postsCountLabel = UILabel()
    postsCountLabel.text = L10n.postsCountText(viewModel.createdPostsCount)
    accountInfoStackView.addArrangedSubview(postsCountLabel)
    let quotesCountLabel = UILabel()
    quotesCountLabel.text = L10n.quotesCountText(viewModel.createdQuotesCount)
    accountInfoStackView.addArrangedSubview(quotesCountLabel)
    let repostsCountLabel = UILabel()
    repostsCountLabel.text = L10n.repostsCountText(viewModel.createdRepostsCount)
    accountInfoStackView.addArrangedSubview(repostsCountLabel)

    accountCreationDateLabel.text = L10n.accountCreateionDateText(viewModel.accountCreationDateString)
  }
}

extension ProfileHeaderView: ViewCodable {
  func buildViewHierarchy() {
    addSubview(profileImageView)
    addSubview(userNameLabel)
    addSubview(accountInfoStackView)
    addSubview(accountCreationDateLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30.0),
      profileImageView.widthAnchor.constraint(equalToConstant: 100.0),
      profileImageView.heightAnchor.constraint(equalToConstant: 100.0),
      profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10.0),
      userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      accountInfoStackView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20.0),
      accountInfoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      accountCreationDateLabel.topAnchor.constraint(equalTo: accountInfoStackView.bottomAnchor, constant: 10.0),
      accountCreationDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30.0),
      accountCreationDateLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }

  func configureView() {
    accessibilityIdentifier = AccessibilityIdentifier.`self`
  }
}
