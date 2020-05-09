//
//  UIViewController+Extension.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    func blinkBackground(flashCount: Float = 2) {
        view.flash(numberOfFlashes: flashCount) { [weak self] in
            guard let self = self else { return }
            self.changeInterfaceStyle()
        }
    }
    
    private func changeInterfaceStyle() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
           return
        }
        
        appDelegate.changeInterfaceStyle()
    }
}
