//
//  CommandsBuilder.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/8/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

final class CommandsBuilder {
    
    private var window: UIWindow?
    
    func setKeyWindow(_ window: UIWindow?) -> CommandsBuilder {
        self.window = window
        return self
    }
    
    func build() -> [Command] {
        return [
            WindowConfigurationCommand(window: window),
            InterfaceStyleConfigurationCommand(window: window),
            NavigationBarAppearanceCommand()
        ]
    }
}
