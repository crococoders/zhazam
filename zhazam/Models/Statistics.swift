//
//  Statistics.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/10/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct StatisticsApiResponse: Codable {
    let status: Status?
    let message: String?
    let data: [StatisticsResult]?
    
    private enum StatisticsApiResponseCodingKeys: String, CodingKey {
        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StatisticsApiResponseCodingKeys.self)

        status = try container.decodeIfPresent(Status.self, forKey: .status)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        data = try container.decodeIfPresent([StatisticsResult].self, forKey: .data)
    }
}

struct StatisticsResult: Codable {
    let score: Int?
    let unit: String?
    let title: String?
    
    private enum StatisticsResultCodingKeys: String, CodingKey {
        case score
        case unit
        case title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StatisticsResultCodingKeys.self)

        score = try container.decodeIfPresent(Int.self, forKey: .score)
        unit = try container.decodeIfPresent(String.self, forKey: .unit)
        title = try container.decodeIfPresent(String.self, forKey: .title)
    }
}
