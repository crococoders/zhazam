//
//  MovieEndPoint.swift
//  zhazam
//
//  Created by Beknar Danabek on 07/08/2018.
//  Copyright © 2018 crococoders. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
}

public enum EndPoint {
    case addGameScore(score: Int)
}

extension EndPoint: EndPointType {
    
    var environmentBaseURL: String {
        return "typo-server.herokuapp.com/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .addGameScore:
            return "user/score"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .addGameScore(let score):
            return .requestWithParameters(bodyParameters: ["wpm": score], urlParameters: nil)
        }
    }
    
    var header: HTTPHeaders? {
        return nil
    }
}
