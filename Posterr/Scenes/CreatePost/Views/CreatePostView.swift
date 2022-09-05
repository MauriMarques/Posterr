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

  struct AccessibilityIdentifier {
    static let contentTextView = "content_text_view"
    static let createButton = "create_button"
  }

  private lazy var contentTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = .systemFont(ofSize: 18.0)
    textView.delegate = self
    textView.accessibilityIdentifier = AccessibilityIdentifier.contentTextView
    return textView
  }()

  private lazy var parentPostView: ParentPostView = {
    let postView = ParentPostView()
    postView.translatesAutoresizingMaskIntoConstraints = false
    return postView
  }()

  private lazy var charactersCounterLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = L10n.createPostsContentCounterText(0,
                                                    maxCharactersAllowed)
    label.textColor = .lightGray
    label.textAlignment = .right
    return label
  }()

  private lazy var createPostButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(L10n.createButtonTitle, for: .normal)
    button.configuration = .filled()
    button.tintColor = .black
    button.isEnabled = false
    button.addTarget(self,
                     action: #selector(didClickOnCreatePost),
                     for: .touchUpInside)
    button.accessibilityIdentifier = AccessibilityIdentifier.createButton
    return button
  }()

  weak var delegate: CreatePostViewDelegate?

  private let parentPostViewModel: ParentPostViewModel?
  private let maxCharactersAllowed: Int
  private var contentText: String = String() {
    didSet {
      charactersCounterLabel.text = L10n.createPostsContentCounterText(contentText.count,
                                                                       maxCharactersAllowed)
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
    contentTextView.becomeFirstResponder()
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
    addSubview(contentTextView)

    if parentPostViewModel != nil {
      addSubview(parentPostView)
    }
    addSubview(createPostButton)
    addSubview(charactersCounterLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      contentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
      contentTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
      contentTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      contentTextView.heightAnchor.constraint(equalToConstant: 200.0),
      createPostButton.trailingAnchor.constraint(equalTo: contentTextView.trailingAnchor),
      createPostButton.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 20.0),
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

extension CreatePostView: UITextViewDelegate {

  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    guard text.count <= maxCharactersAllowed else {
      return false
    }

    guard let textFieldText = textView.text else {
      return false
    }

    var textAfterChange = textFieldText + text
    if text.isEmpty, textAfterChange.count >= 1 {
      textAfterChange.removeLast()
    }

    if textAfterChange.count <= maxCharactersAllowed {
      contentText = textAfterChange
      textView.textColor = .black
      return true
    }
    return false
  }
}
