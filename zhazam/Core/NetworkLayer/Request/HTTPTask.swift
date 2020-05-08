//
//  HTTPTask.swift
//  zhazam
//
//  Created by Beknar Danabek on 06/08/2018.
//  Copyright © 2018 crococoders. All rights reserved.
//

import Foundation
public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestWithParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestWithParametersAndHeaders(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         additionalHeaders: HTTPHeaders?)
}
