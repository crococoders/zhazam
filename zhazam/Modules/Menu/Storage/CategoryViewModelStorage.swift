//
//  CategoryViewModelStorage.swift
//  zhazam
//
//  Created by Sanzhar Alim on 4/26/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

enum Action {
    case navigate
    case choose
}

protocol CategoryViewModelStorageProtocol {
    var categories: [CategoryViewModel] { get }
    var headerIsHidden: Bool { get }
    var hasLoader: Bool { get }
    var title: String { get }
}

struct CategoryViewModel {
    var title: String
    var viewController: UIViewController?
    
    var action: Action {
        if viewController == nil {
            return .choose
        }
        
        return .navigate
    }
}

struct MenuViewModelStorage: CategoryViewModelStorageProtocol {
    var categories: [CategoryViewModel]
    var headerIsHidden: Bool = false
    var hasLoader: Bool = false
    var title: String = R.string.localizable.menu().lowercased()
    
    init() {
        categories = [CategoryViewModel(title: R.string.localizable.play(),
                                        viewController:
                                            MenuViewController(storage: GameModesViewModelStorage())),
                      CategoryViewModel(title: R.string.localizable.leaderboard(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.statistics(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.settings(),
                                        viewController: MenuViewController(storage: SettingsViewModelStorage()))]
    }
}

struct GameModesViewModelStorage: CategoryViewModelStorageProtocol {
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

struct SettingsViewModelStorage: CategoryViewModelStorageProtocol {
    var categories: [CategoryViewModel]
    var headerIsHidden: Bool = true
    var hasLoader: Bool = true
    var title: String = R.string.localizable.settings().lowercased()
    
    init() {
        categories = [CategoryViewModel(title: R.string.localizable.nickname(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.light(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.language(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.share(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.contact(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.rate(), viewController: nil)]
    }
}
