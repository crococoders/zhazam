//
//  Handler.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol Handler {
    var router: Router<EndPoint> { get }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Error>
}

extension Handler {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Error> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
}
