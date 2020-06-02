//
//  LeaderBoardResult.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/31/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct LeaderBoardResultApiResponse: Codable {
    var data: [LeaderBoardResult]?
    
    private enum LeaderBoardResultApiResponseCodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LeaderBoardResultApiResponseCodingKeys.self)
        
        data = try container.decodeIfPresent([LeaderBoardResult].self, forKey: .data)
    }
}

struct LeaderBoardResult: Codable {
    var user: Username?
    var score: GameTypeApiReponse?
    
    private enum LeaderBoardResultCodingKeys: String, CodingKey {
        case user
        case score
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LeaderBoardResultCodingKeys.self)
        
        user = try container.decode(Username.self, forKey: .user)
        score = try container.decode(GameTypeApiReponse.self, forKey: .score)
    }
}
