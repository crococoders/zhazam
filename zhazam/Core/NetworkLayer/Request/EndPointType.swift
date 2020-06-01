//
//  EndPointType.swift
//  zhazam
//
//  Created by Beknar Danabek on 06/08/2018.
//  Copyright © 2018 crococoders. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var header: HTTPHeaders? { get }
    
}
