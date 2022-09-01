//
//  Post+ViewModels.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 01/09/22.
//

import Foundation
import UIKit

extension Post: PostTableCellViewModel {
  var postHeaderViewModel: PostHeaderViewViewModel {
    self
  }

  var contentText: String {
    self.content ?? ""
  }
}

extension Post: QuoteTableViewCellViewModel & RepostTableViewCellViewModel {
  var parentPostViewModel: ParentPostViewViewModel {
    self
  }
}

extension Post: PostHeaderViewViewModel {
  var creatorUserName: String {
    self.creator.name
  }

  var creationDateString: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yy"
    let date = Date(timeIntervalSince1970: self.creationTimestamp)
    return dateFormatter.string(from: date)
  }
}

extension Post: ParentPostViewViewModel {
  var parentPostHeaderViewModel: PostHeaderViewViewModel {
    guard let parentPost = parentPost else {
      return self
    }
    return parentPost
  }

  var parentContentText: String {
    self.parentPost?.content ?? ""
  }
}
