//
//  CreatePostInteractor.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation

protocol CreatePostInteractable {
  var router: CreatePostRouting? { get set }
  var presenter: CreatePostPresentable { get }
  var listener: CreatePostInteractbleListener? { get set }
}

protocol CreatePostInteractbleListener: AnyObject {
  func didCreatePost(_ post: Post)
  func didCloseCreatePost()
}

class CreatePostInteractor: CreatePostInteractable {

  weak var router: CreatePostRouting?
  weak var listener: CreatePostInteractbleListener?

  var presenter: CreatePostPresentable

  private let sessionService: SessionService
  private let postService: PostService
  private let postType: PostType

  init(presenter: CreatePostPresentable,
       sessionService: SessionService,
       postService: PostService,
       postType: PostType) {
    self.presenter = presenter
    self.sessionService = sessionService
    self.postService = postService
    self.postType = postType
    self.presenter.listener = self
  }
}

extension CreatePostInteractor: CreatePostPresentableListener {

  func didLoad() {
    guard let user = sessionService.user else {
      listener?.didCloseCreatePost()
      return
    }
    presenter.loadUser(user)
  }

  func didClickOnCreatePost(content: String?) {
    guard let user = sessionService.user else {
      listener?.didCloseCreatePost()
      return
    }
    let post: Post?
    switch postType {
    case .normal:
      post = postService.createPost(content: content ?? "",
                                    creator: user)
    case let .quote(parentPost):
      if parentPost.type == .repost, let parentParentPost = parentPost.parentPost {
        post = postService.quotePost(content: content ?? "",
                                     parentPost: parentParentPost,
                                     creator: user)
      } else {
        post = postService.quotePost(content: content ?? "",
                                     parentPost: parentPost,
                                     creator: user)
      }
    case let .repost(parentPost):
      if parentPost.type == .repost, let parentParentPost = parentPost.parentPost {
        post = postService.repostPost(parentPost: parentParentPost,
                                      creator: user)
      } else {
        post = postService.repostPost(parentPost: parentPost,
                                      creator: user)
      }
    }

    guard let post = post else {
      return
    }
    listener?.didCreatePost(post)
  }

  func didCancel() {
    listener?.didCloseCreatePost()
  }
}
