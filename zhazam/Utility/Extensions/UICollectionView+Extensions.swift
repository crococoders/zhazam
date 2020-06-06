//
//  UICollectionView+Extensions.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 6/7/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as? T else {
            fatalError("register(cellClass:) has not been implemented")
        }
        return cell
    }
}

extension UICollectionView {
    func register(cellClass: AnyClass) {
        let nib = UINib(nibName: "\(cellClass)", bundle: nil)
        register(nib, forCellWithReuseIdentifier: "\(cellClass)")
    }
}
