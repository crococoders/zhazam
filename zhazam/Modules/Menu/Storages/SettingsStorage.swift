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
        categories = [CategoryViewModel(title: R.string.localizable.nickname()),
                      CategoryViewModel(title: R.string.localizable.lights(),
                                        action: .choose,
                                        configuration: ConfigurationViewModel(type: .lights,
                                                                              values: [R.string.localizable.off(),
                                                                                       R.string.localizable.on()])),
                      CategoryViewModel(title: R.string.localizable.language(),
                                        action: .choose),
                      CategoryViewModel(title: R.string.localizable.share()),
                      CategoryViewModel(title: R.string.localizable.contacts()),
                      CategoryViewModel(title: R.string.localizable.rate())]
    }
}
