//
//  LeaderBoardConfigurationModel.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/10/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

final class LeaderBoardConfigurationModel {
    
    var index: Int = 0
    var values: [String]
    var currentValue: String = ""
    
    init(values: [String]) {
        self.values = values
        
        setInitialIndex()
    }
    
    func next() {
        if index + 1 < values.count {
            index += 1
        } else {
            index = 0
        }
        currentValue = values[index]
    }
    
    private func setInitialIndex() {
        currentValue = values[index]
    }
}
