//
//  LeaderBoardResult.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/31/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct LeaderBoardResultApiResponse: Codable {
    var status: Status?
    var message: String?
    var data: [LeaderBoardResult]?
    
    private enum LeaderBoardResultApiResponseCodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LeaderBoardResultApiResponseCodingKeys.self)
        status = try container.decodeIfPresent(Status.self, forKey: .status)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        data = try container.decodeIfPresent([LeaderBoardResult].self, forKey: .data)
    }
}

struct LeaderBoardResult: Codable {
    var username: String?
    var score: Int?
    var unit: String?
    var place: String?
    
    private enum LeaderBoardResultCodingKeys: String, CodingKey {
        case username
        case score
        case unit
        case place
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LeaderBoardResultCodingKeys.self)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        score = try container.decodeIfPresent(Int.self, forKey: .score)
        unit = try container.decodeIfPresent(String.self, forKey: .unit)
        place = try container.decodeIfPresent(String.self, forKey: .place)
    }
}
