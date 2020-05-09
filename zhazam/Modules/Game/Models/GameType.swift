//
//  GameType.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum GameType {
    case classic
    case arcade
    case time
    
    var measurement: String {
        switch self {
        case .classic, .time:
            return "wpm"
        case .arcade:
            return R.string.localizable.time().lowercased()
        }
    }
    
    var unit: String {
        switch self {
        case .classic, .time:
            return "wpm"
        case .arcade:
            return R.string.localizable.sec().lowercased()
        }
    }
}
