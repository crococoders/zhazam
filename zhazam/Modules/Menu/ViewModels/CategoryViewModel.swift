//
//  CategoryViewModel.swift
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

enum ViewControllerType {
    case settings, gameModes, countdown(type: GameType), choice, statistics
}

protocol MenuSubviewsDelegate: AnyObject {}

protocol CategoryStorageProtocol {
    var categories: [CategoryViewModel] { get }
    var headerIsHidden: Bool { get }
    var hasLoader: Bool { get }
    var title: String { get }
}

struct CategoryViewModel {
    var title: String
    var type: ViewControllerType?
    var action: Action = .navigate
    var configuration: ConfigurationViewModel?
    
    func view(_ delegate: MenuSubviewsDelegate) -> UIView {
        switch action {
        case .navigate:
            let buttonView = LoadingButtonView(self)
            buttonView.delegate = delegate as? LoadingButtonViewDelegate
            
            return buttonView
        case .choose:
            let configurationView = MenuConfigurationView(self)
            configurationView.delegate = delegate as? ConfigurationViewDelegate
            
            return configurationView
        }
    }
}
