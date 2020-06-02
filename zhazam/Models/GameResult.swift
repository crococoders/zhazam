//
//  Score.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct GameResultApiResponse: Codable {
    let status: String
    let message: String
    var data: GameResult?
    
    private enum GameResultApiResponseCodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GameResultApiResponseCodingKeys.self)
        
        status = try container.decode(String.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decodeIfPresent(GameResult.self, forKey: .data)
    }
}

struct GameResult: Codable {
    var percentage: String?
    
    private enum GameResultCodingKeys: String, CodingKey {
        case percentage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GameResultCodingKeys.self)
        
        percentage = try container.decode(String.self, forKey: .percentage)
    }
}
