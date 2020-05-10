//
//  LeaderBoardStorage.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/10/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct LeaderBoardStorage {
    var leaderBoards: [[LeaderBoardRowModel]]
    var configuration: LeaderBoardConfigurationModel?
    
    init() {
        
        leaderBoards = [
            [LeaderBoardRowModel(playerName: "Abay", resultCount: "105", measurement: "wpm", placeTitle: "1rd"),
            LeaderBoardRowModel(playerName: "Arman", resultCount: "104", measurement: "wpm", placeTitle: "2nd"),
            LeaderBoardRowModel(playerName: "Aray", resultCount: "103", measurement: "wpm", placeTitle: "3rd"),
            LeaderBoardRowModel(playerName: "Alken", resultCount: "101", measurement: "wpm", placeTitle: "")],
            
            [LeaderBoardRowModel(playerName: "Sanzhar", resultCount: "107", measurement: "levels", placeTitle: "1rd"),
            LeaderBoardRowModel(playerName: "Sara", resultCount: "106", measurement: "levels", placeTitle: "2nd"),
            LeaderBoardRowModel(playerName: "Sultan", resultCount: "105", measurement: "levels", placeTitle: "3rd"),
            LeaderBoardRowModel(playerName: "Samara", resultCount: "104", measurement: "levels", placeTitle: "")],
        
            [LeaderBoardRowModel(playerName: "Nurbek", resultCount: "100", measurement: "wpm", placeTitle: "1rd"),
            LeaderBoardRowModel(playerName: "Nursultan", resultCount: "99", measurement: "wpm", placeTitle: "2nd"),
            LeaderBoardRowModel(playerName: "Nartay", resultCount: "98", measurement: "wpm", placeTitle: "3rd"),
            LeaderBoardRowModel(playerName: "Nariman", resultCount: "97", measurement: "wpm", placeTitle: "")]
        ]
        
        configuration = LeaderBoardConfigurationModel(values: [R.string.localizable.classic(),
                                                               R.string.localizable.arcade(),
                                                               R.string.localizable.time()])
    }
}
