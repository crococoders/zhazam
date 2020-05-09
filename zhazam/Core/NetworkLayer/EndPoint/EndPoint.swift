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
    case createUser(username: String)
    case getUsername
    case getStatistics
}

extension EndPoint: EndPointType {
    
    var environmentBaseURL: String {
        return "http://typo-server.herokuapp.com/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .addGameScore:
            return "user/score"
        case .createUser, .getUsername:
            return "user"
        case .getStatistics:
            return "user/stats"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .addGameScore:
            return .post
        case .createUser:
            return .put
        case .getUsername, .getStatistics:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .addGameScore(let score):
            return .requestWithParameters(bodyParameters: ["wpm": score], urlParameters: nil)
        case .createUser(let username):
            return .requestWithParameters(bodyParameters: ["username": username], urlParameters: nil)
        case .getUsername, .getStatistics:
            return .request
        }
    }
    
    var header: HTTPHeaders? {
        return nil
    }
}
