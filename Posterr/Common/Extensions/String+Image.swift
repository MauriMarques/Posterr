//
//  String+Image.swift
//  Posterr
//
//  Created by Maurício Martinez Marques on 31/08/22.
//

import Foundation
import UIKit

extension String {

  func image(withAttributes attributes: [NSAttributedString.Key: Any]? = nil,
             size: CGSize? = nil) -> UIImage? {
    let selfNSString = self as NSString
    let size = size ?? selfNSString.size(withAttributes: attributes)
    return UIGraphicsImageRenderer(size: size).image { _ in
      selfNSString.draw(in: CGRect(origin: .zero,
                                   size: size),
                        withAttributes: attributes)
    }
  }
}
