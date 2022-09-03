//
//  CreatePostView.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

protocol CreatePostViewDelegate: AnyObject {
  func didClickOnCreatePost(content: String)
}

final class CreatePostView: UIView {

  private lazy var contentTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "What's happening?"
    textField.contentVerticalAlignment = .top
    textField.delegate = self
    return textField
  }()

  private lazy var parentPostView: ParentPostView = {
    let postView = ParentPostView()
    postView.translatesAutoresizingMaskIntoConstraints = false
    return postView
  }()

  private lazy var charactersCounterLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "0/\(maxCharactersAllowed)"
    label.textColor = .lightGray
    label.textAlignment = .right
    return label
  }()

  private lazy var createPostButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Create", for: .normal)
    button.configuration = .filled()
    button.tintColor = .black
    button.isEnabled = false
    button.addTarget(self,
                     action: #selector(didClickOnCreatePost),
                     for: .touchUpInside)
    return button
  }()

  weak var delegate: CreatePostViewDelegate?

  private let parentPostViewModel: ParentPostViewModel?
  private let maxCharactersAllowed: Int
  private var contentText: String = String() {
    didSet {
      charactersCounterLabel.text = "\(contentText.count)/\(maxCharactersAllowed)"
      createPostButton.isEnabled = !contentText.isEmpty
    }
  }

  init(maxCharactersAllowed: Int = 777,
       parentPostViewModel: ParentPostViewModel? = nil) {
    self.maxCharactersAllowed = maxCharactersAllowed
    self.parentPostViewModel = parentPostViewModel
    super.init(frame: .zero)
    setupCodableView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func becomeFirstResponder() -> Bool {
    contentTextField.becomeFirstResponder()
  }

  @objc
  private func didClickOnCreatePost() {
    guard contentText.count <= maxCharactersAllowed else {
      return
    }
    delegate?.didClickOnCreatePost(content: contentText)
  }
}

extension CreatePostView: ViewCodable {
  func buildViewHierarchy() {
    addSubview(contentTextField)

    if parentPostViewModel != nil {
      addSubview(parentPostView)
    }
    addSubview(createPostButton)
    addSubview(charactersCounterLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      contentTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
      contentTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
      contentTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      contentTextField.heightAnchor.constraint(equalToConstant: 200.0),
      createPostButton.trailingAnchor.constraint(equalTo: contentTextField.trailingAnchor),
      createPostButton.topAnchor.constraint(equalTo: contentTextField.bottomAnchor, constant: 20.0),
      charactersCounterLabel.trailingAnchor.constraint(equalTo: createPostButton.leadingAnchor, constant: -10.0),
      charactersCounterLabel.centerYAnchor.constraint(equalTo: createPostButton.centerYAnchor)
    ])

    if parentPostViewModel != nil {
      NSLayoutConstraint.activate([
        parentPostView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
        parentPostView.topAnchor.constraint(equalTo: createPostButton.bottomAnchor),
        parentPostView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
        parentPostView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
      ])
    }
  }

  func configureView() {
    guard let parentPostViewModel = parentPostViewModel else {
      return
    }
    parentPostView.setViewModel(parentPostViewModel)
  }
}

extension CreatePostView: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    didClickOnCreatePost()
    return true
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard string.count <= maxCharactersAllowed else {
      return false
    }

    guard let textFieldText = textField.text else {
      return false
    }

    var textAfterChange = textFieldText + string
    if string.isEmpty {
      textAfterChange.removeLast()
    }

    if textAfterChange.count <= maxCharactersAllowed {
      contentText = textAfterChange
      return true
    }
    return false
  }
}
