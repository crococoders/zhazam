//
//  StatisticsCollectionCell.swift
//  zhazam
//
//  Created by Abai Kalikov on 4/30/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class StatisticsCollectionCell: UICollectionViewCell {
    
    @IBOutlet private var totalResult: UILabel!
    @IBOutlet private var measurement: UILabel!
    @IBOutlet private var resultTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureItems(model: StatisticsViewModel) {
        self.totalResult.text = model.totalResult
        self.measurement.text = model.measurement
        self.resultTitle.text = model.resultTitle
    }
}
