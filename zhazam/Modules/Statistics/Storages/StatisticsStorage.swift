//
//  StatisticsStorage.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct StatisticsStorage {
    var statistics: [StatisticsRowModel]
    
    init() {
        statistics = [StatisticsRowModel(totalResult: "30", measurement: "wpm", resultTitle: "best result"),
                      StatisticsRowModel(totalResult: "20", measurement: "wpm", resultTitle: "worst result"),
                      StatisticsRowModel(totalResult: "12", measurement: "levels", resultTitle: "best arcade result"),
                      StatisticsRowModel(totalResult: "3", measurement: "levels", resultTitle: "worst arcade result")]
    }
}
