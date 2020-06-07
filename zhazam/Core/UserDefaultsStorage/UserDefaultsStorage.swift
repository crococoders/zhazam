//
//  UserDefaultsStorage.swift
//  zhazam
//
//  Created by Sanzhar Alim on 6/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct UserDefaultsStorage {}

extension UserDefaultsStorage {
    @UserDefaultsBacked(key: "isDarkModeEnabled", defaultValue: false)
    static var isDarkModeEnabled: Bool
}

extension UserDefaultsStorage {
    @UserDefaultsBacked(key: "isOnboardingCompleted", defaultValue: false)
    static var isOnboardingCompleted: Bool
}

extension UserDefaultsStorage {
    @UserDefaultsBacked(key: "isAppLanguageSet", defaultValue: "en")
    static var language: String
}
