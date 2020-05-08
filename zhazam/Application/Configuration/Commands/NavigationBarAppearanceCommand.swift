//
//  NavigationBarAppearanceCommand.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/8/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

struct NavigationBarAppearanceCommand: Command {
    
    func execute() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
        
        let fontAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(named: R.color.textColor.name)!,
             NSAttributedString.Key.font: UIFont(name: R.font.helveticaNeueBold.fontName, size: 20)!]
        
        UINavigationBar.appearance().backIndicatorImage = UIImage()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
        UIBarButtonItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
}
