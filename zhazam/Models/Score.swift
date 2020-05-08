//
//  Score.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct ScoreApiResponse: Codable {
    let status: String
    let message: String
    let data: Score
    
    private enum ScoreApiResponseCodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ScoreApiResponseCodingKeys.self)
        
        status = try container.decode(String.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decode(Score.self, forKey: .data)
    }
}

struct Score: Codable {
    let percentage: String
    
    private enum ScoreCodingKeys: String, CodingKey {
        case percentage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ScoreCodingKeys.self)
        
        percentage = try container.decode(String.self, forKey: .percentage)
    }
}
