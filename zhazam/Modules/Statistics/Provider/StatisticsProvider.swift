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
        NetworkManager.shared.getStatistics { statistics in
            guard let statistics = statistics,
                let typeStatistics = statistics.bestTypes else { return }
            
            typeStatistics.forEach { stats in
                statisticsArray.append(StatisticsViewModel(totalResult: String(stats.wpm ?? 0),
                                                          measurement: stats.type?.name?.getUnit() ?? "",
                                                          resultTitle: stats.type?.name?.getName() ?? ""))
            }
            
            let bestAllResultTitle = "Best (\(statistics.bestAll?.type?.name?.getName() ?? ""))"
            statisticsArray.append(StatisticsViewModel(totalResult: String(statistics.bestAll?.wpm ?? 0),
                                                      measurement: statistics.bestAll?.type?.name?.getUnit() ?? "",
                                                      resultTitle: bestAllResultTitle))
            statisticsArray.append(StatisticsViewModel(totalResult: (statistics.averageAll ?? 0.0).formatted(),
                                                      measurement: "wpm",
                                                      resultTitle: R.string.localizable.averageAll()))
            statisticsArray.append(StatisticsViewModel(totalResult: (statistics.averageLast ?? 0.0).formatted(),
                                                      measurement: "wpm",
                                                      resultTitle: R.string.localizable.averageLast()))
            self.statistics = statisticsArray
        }
    }
}
