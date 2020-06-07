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
    var hasLoader: Bool = false
    var title: String = "Settings"
    
    private let lightsViewModel = ConfigurationViewModel(type: .lights,
                                                         values: ["Off",
                                                                  "On"])
    private let languagesViewModel = ConfigurationViewModel(type: .language,
                                                            values: ["LanguageEn",
                                                                     "LanguageRu",
                                                                     "LanguageUk"])
    
    init() {
        categories = [CategoryViewModel(title: "Nickname", type: .choice),
                      CategoryViewModel(title: "Lights",
                                        action: .choose,
                                        configuration: lightsViewModel),
                      CategoryViewModel(title: "Language",
                                        action: .choose,
                                        configuration: languagesViewModel),
                      CategoryViewModel(title: "Share"),
                      CategoryViewModel(title: "Contacts"),
                      CategoryViewModel(title: "Rate")]
    }
}
