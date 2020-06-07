//
//  TimeModeCell.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 6/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class TimeModeCell: UICollectionViewCell {

    @IBOutlet private var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.textColor = R.color.defaultGray()
    }
    
    func configure(with word: String) {
        label.text = word
    }
    
    func configure(with attributtedWord: NSAttributedString) {
        label.attributedText = attributtedWord
    }
}
