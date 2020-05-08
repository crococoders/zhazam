//
//  Collections+Extension.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
}
