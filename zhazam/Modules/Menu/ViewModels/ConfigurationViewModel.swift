//
//  ConfigurationViewModel.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/7/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum ConfigurationCellType {
    case lights
    case language
}

enum Language: String {
    case en, ru, uk
}

final class ConfigurationViewModel {
    var index: Int = 0
    
    var type: ConfigurationCellType
    var values: [String]
    var currentValue: String = ""
    var currentLanguage: String = ""
    
    private var languages: [String] = ["en", "ru", "uk"]
    
    init(type: ConfigurationCellType, values: [String]) {
        self.type = type
        self.values = values
        
        setInitialIndex()
    }
    
    func next() {
        if index + 1 < values.count {
            index += 1
        } else {
            index = 0
        }
        
        currentValue = values[index]
        currentLanguage = languages[index]
    }
    
    private func setInitialIndex() {
        switch type {
        case .lights:
            index = UserDefaultsStorage.isDarkModeEnabled ? 0 : 1
        case .language:
            setupIndexForCurrentLanguage()
        }
        
        currentValue = values[index]
    }
    
    private func setupIndexForCurrentLanguage() {
        guard let language = Language(rawValue: UserDefaultsStorage.language) else { return }
        
        switch language {
        case .en:
            index = 0
        case .ru:
            index = 1
        case .uk:
            index = 2
        }
        
        currentLanguage = languages[index]
    }
}
