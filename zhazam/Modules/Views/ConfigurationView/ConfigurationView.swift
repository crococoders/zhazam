//
//  ConfigurationView.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ConfigurationView: UIView {

    var onTap: Callback?
    var value: String? {
        didSet {
            valueLabel.text = value
        }
    }
    
    @IBOutlet private var keyLabel: UILabel!
    @IBOutlet private var valueLabel: UILabel!
    
    convenience init(key: String, value: String) {
        self.init(frame: CGRect.zero)
        
        keyLabel.text = key
        valueLabel.text = value
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadFromNib()
    }
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
