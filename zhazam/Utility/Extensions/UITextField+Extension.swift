//
//  UITextField+Extension.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/7/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setLeftPaddingPoints( _ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints( _ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
