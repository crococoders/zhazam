//
//  Int+Extension.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

extension Int {
    func formattedPercentage() -> String {
        if self < 10 {
            return "00\(self)."
        } else if self < 100 && self >= 10 {
            return "0\(self)."
        }
        
        return "\(self)."
    }
}
