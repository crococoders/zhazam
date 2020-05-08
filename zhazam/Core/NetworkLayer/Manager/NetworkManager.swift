//
//  NetworkManager.swift
//  zhazam
//
//  Created by Beknar Danabek on 07/08/2018.
//  Copyright © 2018 crococoders. All rights reserved.
//

import Foundation

struct NetworkManager: Handler {
    static let environment: NetworkEnvironment = .production
    static let apiKey = "94258d5ceb30d59a61d1253b2e3b3be2"
    private let router = Router<EndPoint>()
    
    
}
