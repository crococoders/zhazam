//
//  LanguageManager.swift
//  zhazam
//
//  Created by Sanzhar Alim on 6/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class LanguageManager {
    static let shared = LanguageManager()
    
    func setLanguage(_ language: String) {
        UserDefaultsStorage.language = language
        
        NotificationCenter.default.post(name: NSNotification.Name("languageChanged"), object: self)
    }
}
