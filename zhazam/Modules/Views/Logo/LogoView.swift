//
//  LogoView.swift
//  zhazam
//
//  Created by Sanzhar Alim on 4/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class LogoView: UIView {
    private let appName = R.string.localizable.appName().lowercased()
    
    private enum Constants {
        static let cursorAnimationDuration: TimeInterval = 0.8
        static let timerTimeInterval = 0.4
    }
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        animate()
    }
    
    private func animate() {
        animateTitle {
            DispatchQueue.main.async {
                self.animateCursor()
            }
        }
    }
    
    private func animateCursor() {
        UIView.animate(withDuration: Constants.cursorAnimationDuration,
                       delay: 0,
                       options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.cursorView.alpha = 1
        }, completion: nil)
    }
    
    private func animateTitle(completion: @escaping Callback) {
        var characterIndex = 0
        let characterArray = Array(self.appName)
        
        Timer.scheduledTimer(withTimeInterval: Constants.timerTimeInterval, repeats: true) { timer in
            self.titleLabel.text! += String(characterArray[characterIndex])
            characterIndex += 1
            
            if characterArray.count == characterIndex {
                timer.invalidate()
                completion()
            }
        }
    }
}
