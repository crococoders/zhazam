//
//  UIFont+Extension.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/7/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

enum Font: String {
    case bold = "HelveticaNeue-Bold"
    case light = "HelveticaNeue-Light"
}

extension UIFont {
    
    convenience init?(_ customFont: Font, withSize size: CGFloat) {
        self.init(name: customFont.rawValue, size: size)
    }
    
}

