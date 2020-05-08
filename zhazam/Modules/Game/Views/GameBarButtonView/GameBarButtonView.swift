//
//  GameBarButtonView.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class GameBarButtonView: UIView {
    @IBOutlet private var scoreLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadFromNib()
    }
    
    func setScore(score: Int) {
        scoreLabel.text = "\(score)"
    }
}
