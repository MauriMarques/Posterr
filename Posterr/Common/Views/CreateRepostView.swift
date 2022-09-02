//
//  CreateRepostView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 02/09/22.
//

import Foundation
import UIKit

protocol CreateRepostViewDelegate: AnyObject {
  func didClickOnRepostPost()
}

final class CreateRepostView: UIView {

  private lazy var parentPostView: ParentPostView = {
    let postView = ParentPostView()
    postView.translatesAutoresizingMaskIntoConstraints = false
    return postView
  }()

  private lazy var createPostButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Create", for: .normal)
    button.configuration = .filled()
    button.tintColor = .black
    button.addTarget(self,
                     action: #selector(didClickOnCreateRepost),
                     for: .touchUpInside)
    return button
  }()

  weak var delegate: CreateRepostViewDelegate?

  private let parentPostViewModel: ParentPostViewModel

  init(parentPostViewModel: ParentPostViewModel) {
    self.parentPostViewModel = parentPostViewModel
    super.init(frame: .zero)
    setupCodableView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc func didClickOnCreateRepost() {
    delegate?.didClickOnRepostPost()
  }
}

extension CreateRepostView: ViewCodable {
  func buildViewHierarchy() {
    addSubview(parentPostView)
    addSubview(createPostButton)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      parentPostView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
      parentPostView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
      parentPostView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
      createPostButton.trailingAnchor.constraint(equalTo: parentPostView.trailingAnchor),
      createPostButton.topAnchor.constraint(equalTo: parentPostView.bottomAnchor, constant: 20.0),
      createPostButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
    ])
  }

  func configureView() {
    parentPostView.setViewModel(parentPostViewModel)
  }
}
