//
//  UITextView+Extension.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/10/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UITextView {
    var visibleRange: NSRange? {
        if let start = closestPosition(to: contentOffset),
            let end = characterRange(at: CGPoint(x: contentOffset.x + bounds.maxX,
                                                 y: contentOffset.y + bounds.maxY))?.end {
            return NSRange(location: offset(from: beginningOfDocument, to: start),
                           length: offset(from: start, to: end))
        }
        return nil
    }
}
