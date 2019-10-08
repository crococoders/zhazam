//
//  UIViewController+Extension.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/7/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func create<T: UIViewController>(name: String = "Main") -> T {
        let vc: T = UIStoryboard.create(with: name, identifier: self.identifier) as! T
        return vc
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
