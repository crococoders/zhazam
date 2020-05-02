//
//  UIView+Extension.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/7/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

extension UIView {
    /// Loads an XIB file with the same name as view and adds the first object from the file as a subview
    func loadFromNib(_ bundle: Bundle? = Bundle.main) {
        let className = String(describing: type(of: self))
        guard let view = bundle?.loadNibNamed(className,
                                              owner: self,
                                              options: nil)?.first as? UIView else {
                                                fatalError("No xib file found for UIView object: \(self)")
        }
        
        view.frame = bounds
        addSubview(view)
    }
    
    /// Loads an XIB file with the same name and a specific view type
    class func viewFromNib<T: UIView>(_ bundle: Bundle? = Bundle.main) -> T {
        guard let view = bundle?.loadNibNamed(String(describing: T.self),
                                              owner: self,
                                              options: nil)?.first as? T else {
                                                fatalError("No xib with type \(T.self)")
        }
        
        return view
    }
}
