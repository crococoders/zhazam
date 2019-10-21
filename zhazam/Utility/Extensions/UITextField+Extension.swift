//
//  UITextField+Extension.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/8/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

extension UITextField {
    
    var isActive: Bool {
        return self.isFirstResponder
    }
    
    var isInteractionEnabled: Bool {
        return self.isEnabled
    }
    
    func becomeResponder() {
        self.becomeFirstResponder()
    }
    
    func resignResponder() {
        self.resignFirstResponder()
    }
    
}
