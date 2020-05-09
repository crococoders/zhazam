//
//  Statistics.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/10/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum GameTypeApi: String, Codable {
    case classic, arcade, timer
}

struct StatisticsApiResponse: Codable {
    var status: Status?
    var message: String?
    var data: Statistics?
}

struct Statistics {
    var bestAll: GameTypeApiReponse?
    var bestTypes: [GameTypeApiReponse]?
    var averageAll: Double?
    var averageLast: Double?
}

extension Statistics: Codable {
    private enum StatisticsCodingKeys: String, CodingKey {
        case bestAll = "best_all"
        case bestTypes = "best_types"
        case averageAll = "average_all"
        case averageLast = "average_last"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StatisticsCodingKeys.self)
        
        bestAll = try container.decodeIfPresent(GameTypeApiReponse.self, forKey: .bestAll)
        bestTypes = try container.decodeIfPresent([GameTypeApiReponse].self, forKey: .bestTypes)
        averageAll = try container.decodeIfPresent(Double.self, forKey: .averageAll)
        averageLast = try container.decodeIfPresent(Double.self, forKey: .averageLast)
    }
}

struct GameTypeApiReponse: Codable {
    var wpm: Int?
    var type: GameMode?
}

struct GameMode: Codable {
    var name: GameTypeApi?
}
