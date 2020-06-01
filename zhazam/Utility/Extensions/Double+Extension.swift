//
//  Double+Extension.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/10/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

extension Double {
    func formatted() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return String(formatter.string(from: number) ?? "")
    }
}
