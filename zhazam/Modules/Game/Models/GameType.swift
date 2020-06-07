//
//  GameType.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum GameType: String {
    case classic
    case arcade
    case time
    case multiplayer
    
    var measurement: String {
        switch self {
        case .classic:
            return "wpm"
        case .arcade, .time:
            return "Time".localized.lowercased()
        case .multiplayer:
            return ""
        }
    }
    
    var unit: String {
        switch self {
        case .classic, .time:
            return "wpm"
        case .arcade:
            return "Sec".localized.lowercased()
        case .multiplayer:
            return ""
        }
    }
}
