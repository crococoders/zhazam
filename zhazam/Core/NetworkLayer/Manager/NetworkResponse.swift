//
//  NetworkResponse.swift
//  zhazam
//
//  Created by Beknar Danabek on 07/08/2018.
//  Copyright © 2018 crococoders. All rights reserved.
//

import Foundation

enum NetworkResponse: String, Error {
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data decode"
    case unableToDecode = "We could not decode the response"
    case noNetwork = "Please check your internet connection"
}
