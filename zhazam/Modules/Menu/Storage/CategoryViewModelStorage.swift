//
//  CategoryViewModelStorage.swift
//  zhazam
//
//  Created by Sanzhar Alim on 4/26/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol CategoryViewModelStorageProtocol {
    var categories: [CategoryViewModel] { get }
    var headerIsHidden: Bool { get }
}

struct CategoryViewModel {
    var title: String
    var viewController: UIViewController?
}

struct MenuViewModelStorage: CategoryViewModelStorageProtocol {
    var categories: [CategoryViewModel]
    var headerIsHidden: Bool = false
    
    init() {
        categories = [CategoryViewModel(title: R.string.localizable.play(),
                                        viewController:
                                            MenuViewController(storage: GameModesViewModelStorage())),
                      CategoryViewModel(title: R.string.localizable.leaderboard(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.statistics(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.settings(), viewController: nil)]
    }
}

struct GameModesViewModelStorage: CategoryViewModelStorageProtocol {
    var categories: [CategoryViewModel]
    var headerIsHidden: Bool = true
    
    init() {
        categories = [CategoryViewModel(title: R.string.localizable.classic(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.arcade(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.time(), viewController: nil)]
    }
}
