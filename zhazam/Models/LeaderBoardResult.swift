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
    var user: UserResult?
    var score: ScoreResult?
    
    private enum LeaderBoardResultCodingKeys: String, CodingKey {
        case user
        case score
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LeaderBoardResultCodingKeys.self)
        
        user = try container.decode(UserResult.self, forKey: .user)
        score = try container.decode(ScoreResult.self, forKey: .score)
    }
}

struct UserResult: Codable {
    var userName: String
    
    private enum UserResultCodingKeys: String, CodingKey {
        case userName = "username"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserResultCodingKeys.self)
        
        userName = try container.decode(String.self, forKey: .userName)
    }
}

struct ScoreResult: Codable {
    var wpm: Int
    var type: GameTypeResult?
    
    private enum ScoreResultCodingKeys: String, CodingKey {
        case wpm
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ScoreResultCodingKeys.self)
        
        wpm = try container.decode(Int.self, forKey: .wpm)
        type = try container.decode(GameTypeResult.self, forKey: .type)
    }
}

struct GameTypeResult: Codable {
    var gameType: String
    
    private enum GameTypeResultCodingKeys: String, CodingKey {
        case gameType = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GameTypeResultCodingKeys.self)
        
        gameType = try container.decode(String.self, forKey: .gameType)
    }
}
