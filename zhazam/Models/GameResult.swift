//
//  Score.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct GameResultApiResponse: Codable {
    var status: String?
    var message: String?
    var data: GameResult?
}

struct GameResult: Codable {
    var percentage: Double?
}
