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
    case popular
    case newMovies(page:Int)
}

extension EndPoint: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production:
            return "https://api.themoviedb.org/3/movie/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .popular:
            return .requestWithParameters(bodyParameters: nil,
                                      urlParameters: ["api_key": NetworkManager.apiKey,
                                                      "language": "en"])
        default:
            return .request
        }
    }
    
    var header: HTTPHeaders? {
        return nil
    }
}
