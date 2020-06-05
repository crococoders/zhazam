//
//  MainMenuStorage.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct MainMenuStorage: CategoryStorageProtocol {
    var categories: [CategoryViewModel]
    var headerIsHidden: Bool = false
    var hasLoader: Bool = false
    var title: String = R.string.localizable.menu().lowercased()
    
    init() {
        categories = [CategoryViewModel(title: R.string.localizable.play(), type: .gameModes),
                      CategoryViewModel(title: R.string.localizable.leaderboard()),
                      CategoryViewModel(title: R.string.localizable.statistics(), type: .statistics),
                      CategoryViewModel(title: R.string.localizable.settings(), type: .settings)]
    }
}
