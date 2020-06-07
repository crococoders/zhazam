//
//  StatisticsStorage.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct StatisticsStorage {
    var statistics: [StatisticsViewModel]
    
    init() {
        statistics = [StatisticsViewModel(totalResult: "30", measurement: "wpm", resultTitle: "best result"),
                      StatisticsViewModel(totalResult: "20", measurement: "wpm", resultTitle: "worst result"),
                      StatisticsViewModel(totalResult: "12", measurement: "levels", resultTitle: "best arcade result"),
                      StatisticsViewModel(totalResult: "3", measurement: "levels", resultTitle: "worst arcade result")]
    }
}
