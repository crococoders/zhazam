//
//  TitledTextViewModel.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

// TODO: - refactor
struct TitledTextViewModel {
    var title: String
    var placeholder: String
    var actions: [String: Callback] = [:]
    var onDismiss: Callback?
}
