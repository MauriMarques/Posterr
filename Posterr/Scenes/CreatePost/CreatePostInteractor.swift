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

final class CreatePostInteractor: CreatePostInteractable {

  weak var router: CreatePostRouting?
  weak var listener: CreatePostInteractbleListener?

  var presenter: CreatePostPresentable

  private let sessionService: SessionService
  private let appConfig: PosterrAppConfig
  private let postService: PostService
  private let postType: PostType

  init(presenter: CreatePostPresentable,
       sessionService: SessionService,
       appConfig: PosterrAppConfig,
       postService: PostService,
       postType: PostType) {
    self.presenter = presenter
    self.sessionService = sessionService
    self.appConfig = appConfig
    self.postService = postService
    self.postType = postType
    self.presenter.listener = self
  }

  private func canCreatePost(_ user: User) -> Bool {
    let posts = postService.postsByCreator(user,
                                           onDate: Date().stripTime())
    return posts.count < appConfig.limitOfPostsPerDay
  }
}

extension CreatePostInteractor: CreatePostPresentableListener {

  func didLoad() {
    guard let user = sessionService.user else {
      listener?.didCloseCreatePost()
      return
    }
    presenter.loadUser(user)
    if !canCreatePost(user) {
      presenter.showPostsCreationLimitReachedAlert()
    }
  }

  func didClickOnCreatePost(content: String?) {
    guard let user = sessionService.user else {
      listener?.didCloseCreatePost()
      return
    }

    if !canCreatePost(user) {
      presenter.showPostsCreationLimitReachedAlert()
    } else {
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
  }

  func didCancel() {
    listener?.didCloseCreatePost()
  }
}
