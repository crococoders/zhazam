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

protocol MenuSubviewsDelegate: AnyObject {}

protocol CategoryStorageProtocol {
    var categories: [CategoryViewModel] { get }
    var headerIsHidden: Bool { get }
    var hasLoader: Bool { get }
    var title: String { get }
}

struct CategoryViewModel {
    var title: String
    var viewController: UIViewController?
    var action: Action = .navigate
    
    func view(_ delegate: MenuSubviewsDelegate) -> UIView {
        switch action {
        case .navigate:
            let buttonView = LoadingButtonView(self)
            buttonView.delegate = delegate as? LoadingButtonViewDelegate
            
            return buttonView
        case .choose:
            let configurationView = ExtendedConfigurationView(self)
            configurationView.delegate = delegate as? ConfigurationViewDelegate
            
            return configurationView
        }
    }
}
