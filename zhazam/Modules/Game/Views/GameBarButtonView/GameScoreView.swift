//
//  GameScoreView.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class GameScoreView: UIView {
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet var measurementLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadFromNib()
    }
    
    func setScore(score: Int, type: GameType) {
        scoreLabel.text = "\(score)"
        measurementLabel.text = type.measurement
    }
}
