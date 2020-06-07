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
        configuration = LeaderBoardConfigurationModel(values: ["Classic".localized,
                                                               "Arcade".localized,
                                                               "Time".localized])
    }
    
    func setLeaderBoards(by type: GameType) {
        var leaderBoardArray: [LeaderBoardViewModel] = []
        NetworkManager.shared.getLeaderBoardResult(by: type) { [weak self] (results) in
            guard let self = self, let results = results else { return }

            results.forEach { (leaderBoards) in
                guard let username = leaderBoards.username, let score = leaderBoards.score,
                    let unit = leaderBoards.unit, let place = leaderBoards.place else { return }

                leaderBoardArray.append(LeaderBoardViewModel(playerName: username,
                                                             resultCount: String(score),
                                                             measurement: unit,
                                                             placeTitle: place))
            }
            self.leaderBoards = leaderBoardArray
        }
    }
}
