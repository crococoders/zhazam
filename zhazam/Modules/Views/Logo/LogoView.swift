//
//  LogoView.swift
//  zhazam
//
//  Created by Sanzhar Alim on 4/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class LogoView: UIView {
    private let appName = R.string.localizable.appName()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private var cursorView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadFromNib()
    }
    
    func animate() {
        animateTitle {
            DispatchQueue.main.async {
                self.animateCursor()
            }
        }
    }
    
    private func animateCursor() {
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.cursorView.alpha = 1
        }, completion: nil)
    }
    
    private func animateTitle(completion: @escaping() -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            for character in self.appName {
                DispatchQueue.main.async {
                    self.titleLabel.text! += String(character)
                }
                
                Thread.sleep(forTimeInterval: 0.4)
            }
            
            completion()
        }
    }
}
