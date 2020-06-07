//
//  InterfaceStyleConfigurationCommand.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

struct InterfaceStyleConfigurationCommand: Command {

    var window: UIWindow?

    func execute() {
        if #available(iOS 13.0, *) {
            let isDarkModeEnabled = UserDefaultsStorage.isDarkModeEnabled
            window?.overrideUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
        }
    }
}
