//
//  LeaderBoardProvider.swift
//  zhazam
//
//  Created by Abai Kalikov on 6/2/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol LeaderBoardProviderDelegate: AnyObject {
    func didUpdate()
}

class LeaderBoardProvider {
    
    weak var delegate: LeaderBoardProviderDelegate?
    var configuration: LeaderBoardConfigurationModel?
    
    var leaderBoards: [LeaderBoardViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdate()
            }
        }
    }
    
    func setConfigurationData() {
        configuration = LeaderBoardConfigurationModel(values: [R.string.localizable.classic(),
                                                               R.string.localizable.arcade(),
                                                               R.string.localizable.time()])
    }
    
    func setLeaderBoards(by type: GameType) {
        var leaderBoardArray: [LeaderBoardViewModel] = []
        NetworkManager.shared.getLeaderBoardResult(by: type) { [weak self] (leaderBoards) in
            guard let self = self, let leaderBoards = leaderBoards else { return }
            
            leaderBoards.forEach { (result) in
                guard let username = result.user?.username,
                    let score = result.score?.wpm,
                    let unit = result.score?.type?.name?.getUnit() else { return }
                
                leaderBoardArray.append(LeaderBoardViewModel(playerName: username,
                                                             resultCount: "\(score)",
                                                             measurement: unit,
                                                             placeTitle: ""))
            }
            self.leaderBoards = leaderBoardArray
        }
    }
}
