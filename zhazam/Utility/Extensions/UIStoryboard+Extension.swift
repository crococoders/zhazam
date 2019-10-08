//
//  UIStoryboard+Extension.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/7/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

extension UIStoryboard {

    class func create<T: UIViewController>(with name: String, identifier: String) -> T {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier) as! T
    }
    
}
