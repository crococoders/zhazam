//
//  TimerRowView.swift
//  zhazam
//
//  Created by Abai Kalikov on 4/23/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class TimerRowView: UIView {
    
    private let rowData: String?
    @IBOutlet private var timerCounterLabel: UILabel!
    
    init(frame: CGRect = .zero, rowData: String) {
        self.rowData = rowData
        super.init(frame: frame)
        
        loadFromNib()
        configureLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        timerCounterLabel.text = rowData
    }
}
