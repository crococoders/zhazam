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

        self.loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureItems(model: StatisticsRowModel) {
        guard let totalResult = model.totalResult,
              let measurement = model.measurement,
              let resultTitle = model.resultTitle else { return }
        self.totalResult.text = totalResult
        self.measurement.text = measurement
        self.resultTitle.text = resultTitle
    }
}
