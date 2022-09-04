//
//  ParentPostViewModelMock.swift
//  PosterrTests
//
//  Created by Maurício Martinez Marques on 04/09/22.
//

@testable import Posterr

struct ParentPostViewModelMock: ParentPostViewModel {
  var parentPostHeaderViewModel: PostHeaderViewModel = PostHeaderViewModelMock()

  var parentContentText: String = """
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of
classical Latin literature from 45 BC, making
"""
}
