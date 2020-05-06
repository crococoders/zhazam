//
//  SettingsStorage.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct SettingsStorage: CategoryStorageProtocol {
    var categories: [CategoryViewModel]
    var headerIsHidden: Bool = true
    var hasLoader: Bool = true
    var title: String = R.string.localizable.settings().lowercased()
    
    init() {
        categories = [CategoryViewModel(title: R.string.localizable.nickname(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.light(), viewController: nil, action: .choose),
                      CategoryViewModel(title: R.string.localizable.language(), viewController: nil, action: .choose),
                      CategoryViewModel(title: R.string.localizable.share(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.contact(), viewController: nil),
                      CategoryViewModel(title: R.string.localizable.rate(), viewController: nil)]
    }
}
