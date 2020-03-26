//
//  WindowConfigurationCommand.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/8/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

struct WindowConfigurationCommand: Command {
    
    var window: UIWindow?
    
    func execute() {
        window?.backgroundColor = .white
        window?.layer.cornerRadius = 10
        window?.layer.masksToBounds = true
        window?.makeKeyAndVisible()
        window?.rootViewController = LoadingViewController()
    }
}
