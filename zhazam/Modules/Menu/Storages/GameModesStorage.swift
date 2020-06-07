//
//  GameModesStorage.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct GameModesStorage: CategoryStorageProtocol {
    var categories: [CategoryViewModel]
    var headerIsHidden: Bool = true
    var hasLoader: Bool = true
    var title: String = "Modes"
    
    init() {
        categories = [CategoryViewModel(title: R.string.localizable.classic(), type: .countdown(type: .classic)),
                      CategoryViewModel(title: R.string.localizable.arcade(), type: .countdown(type: .arcade)),
                      CategoryViewModel(title: R.string.localizable.time(), type: .countdown(type: .time))]
    }
}
