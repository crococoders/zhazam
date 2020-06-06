//
//  StatisticsProvider.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/10/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol StatisticsProviderDelegate: AnyObject {
    func didUpdate()
}

class StatisticsProvider {
    
    weak var delegate: StatisticsProviderDelegate?
    
    var statistics: [StatisticsViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdate()
            }
        }
    }
    
    func setStatistics() {
        var statisticsArray: [StatisticsViewModel] = []
        NetworkManager.shared.getStatistics { [weak self] results in
            guard let self = self, let results = results else { return }
            
            results.forEach { statistics in
                guard let score = statistics.score, let unit = statistics.unit,
                    let title = statistics.title else { return }
                
                statisticsArray.append(StatisticsViewModel(totalResult: String(score),
                                                          measurement: unit,
                                                          resultTitle: title))
            }
            self.statistics = statisticsArray
        }
    }
}
