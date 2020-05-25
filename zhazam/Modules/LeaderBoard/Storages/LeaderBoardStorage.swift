//
//  LeaderBoardStorage.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/10/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct LeaderBoardStorage {
    var leaderBoards: [[LeaderBoardViewModel]]
    var configuration: LeaderBoardConfigurationModel?
    
    init() {
        leaderBoards = [
            [LeaderBoardViewModel(playerName: "Abay", resultCount: "105", measurement: "wpm", placeTitle: "1rd"),
            LeaderBoardViewModel(playerName: "Arman", resultCount: "104", measurement: "wpm", placeTitle: "2nd"),
            LeaderBoardViewModel(playerName: "Aray", resultCount: "103", measurement: "wpm", placeTitle: "3rd"),
            LeaderBoardViewModel(playerName: "Alken", resultCount: "101", measurement: "wpm", placeTitle: "")],
            
            [LeaderBoardViewModel(playerName: "Sanzhar", resultCount: "107", measurement: "levels", placeTitle: "1rd"),
            LeaderBoardViewModel(playerName: "Sara", resultCount: "106", measurement: "levels", placeTitle: "2nd"),
            LeaderBoardViewModel(playerName: "Sultan", resultCount: "105", measurement: "levels", placeTitle: "3rd"),
            LeaderBoardViewModel(playerName: "Samara", resultCount: "104", measurement: "levels", placeTitle: "")],
        
            [LeaderBoardViewModel(playerName: "Nurbek", resultCount: "100", measurement: "wpm", placeTitle: "1rd"),
            LeaderBoardViewModel(playerName: "Nursultan", resultCount: "99", measurement: "wpm", placeTitle: "2nd"),
            LeaderBoardViewModel(playerName: "Nartay", resultCount: "98", measurement: "wpm", placeTitle: "3rd"),
            LeaderBoardViewModel(playerName: "Nariman", resultCount: "97", measurement: "wpm", placeTitle: "")]
        ]
        
        configuration = LeaderBoardConfigurationModel(values: [R.string.localizable.classic(),
                                                               R.string.localizable.arcade(),
                                                               R.string.localizable.time()])
    }
}
