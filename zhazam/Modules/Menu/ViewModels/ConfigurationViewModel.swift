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

final class ConfigurationViewModel {
    var index: Int = 0
    
    var type: ConfigurationCellType
    var values: [String]
    var currentValue: String = ""
    
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
    }
    
    private func setInitialIndex() {
        switch type {
        case .lights:
            index = UserDefaultsStorage.isDarkModeEnabled ? 0 : 1
        default:
            index = 0
        }
        
        currentValue = values[index]
    }
}
