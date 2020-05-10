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
        categories = [CategoryViewModel(title: R.string.localizable.play(),
                                        viewController: MenuViewController(storage: GameModesStorage())),
                      CategoryViewModel(title: R.string.localizable.leaderboard(),
                                        viewController: LeaderBoardViewController(
                                            storage: LeaderBoardStorage())),
                      CategoryViewModel(title: R.string.localizable.statistics(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.settings(),
                                        viewController: MenuViewController(storage: SettingsStorage()))]
    }
}
