//
//  Username.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct UsernameApiResponse: Codable {
    var status: Status?
    var message: String?
    var data: Username?
}

struct Username: Codable {
    var username: String?
}
