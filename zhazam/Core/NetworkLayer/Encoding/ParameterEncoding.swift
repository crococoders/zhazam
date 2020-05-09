//
//  ParameterEncoding.swift
//  zhazam
//
//  Created by Beknar Danabek on 06/08/2018.
//  Copyright © 2018 crococoders. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameters encoding failed"
    case missingURL = "URL is nil"
}
