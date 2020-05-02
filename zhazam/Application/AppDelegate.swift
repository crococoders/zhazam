//
//  AppDelegate.swift
//  zhazam
//
//  Created by Beknar Danabek on 8/20/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        CommandsBuilder()
            .setKeyWindow(window)
            .build()
            .forEach { $0.execute() }
        return true
    }
    
    func changeInterfaceStyle() {
        if #available(iOS 13.0, *) {
            let isDarkModeEnabled = window?.overrideUserInterfaceStyle == .dark
            window?.overrideUserInterfaceStyle = isDarkModeEnabled ? .light : .dark
            UserDefaultsStorage.isDarkModeEnabled = !isDarkModeEnabled
        }
    }
}
