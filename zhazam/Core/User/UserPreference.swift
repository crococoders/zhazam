//
//  UserPreference.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/8/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import Foundation

class UserPreference {
    private let PREFERENCES_NAME = "crococoders.zhazam.user"
    private let USER_NICKNAME = "userNickname"
    
    private let preference: UserDefaults
    
    static let shared = UserPreference()
    
    private init() {
        preference = UserDefaults(suiteName: PREFERENCES_NAME)!
    }
    
    var nickname: String? {
        get {
            return preference.string(forKey: USER_NICKNAME)
        }
        set {
            preference.set(newValue, forKey: USER_NICKNAME)
        }
    }
        
}
