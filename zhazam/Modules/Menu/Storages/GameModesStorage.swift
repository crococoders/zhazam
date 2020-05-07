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
    var title: String = R.string.localizable.modes().lowercased()
    
    init() {
        categories = [CategoryViewModel(title: R.string.localizable.classic(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.arcade(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.time(), viewController: nil)]
    }
}
