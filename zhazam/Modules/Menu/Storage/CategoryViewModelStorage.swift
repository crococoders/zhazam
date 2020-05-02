//
//  CategoryViewModelStorage.swift
//  zhazam
//
//  Created by Sanzhar Alim on 4/26/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct CategoryViewModelStorage {
    let viewModels: [String]
    
    init() {
        viewModels = [R.string.localizable.play(),
                      R.string.localizable.leaderboard(),
                      R.string.localizable.statistics(),
                      R.string.localizable.settings()]
    }
}
