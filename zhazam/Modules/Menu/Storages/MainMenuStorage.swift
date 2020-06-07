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
    var title: String = "Menu"
    
    init() {
        categories = [CategoryViewModel(title: "Play", type: .gameModes),
                      CategoryViewModel(title: "Leaderboard"),
                      CategoryViewModel(title: "Statistics", type: .statistics),
                      CategoryViewModel(title: "Settings", type: .settings)]
    }
}
