//
//  PrimaryTextField.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class PrimaryTextField: UITextField {
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return true
    }
}
