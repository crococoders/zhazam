//
//  UIApplication+Extension.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UIApplication {

    var screenShot: UIImage? {
        if let rootViewController = keyWindow?.rootViewController {
            let scale = UIScreen.main.scale
            let bounds = rootViewController.view.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
            rootViewController.view.drawHierarchy(in: bounds, afterScreenUpdates: true)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return screenshot
        }
        return nil
    }
}
