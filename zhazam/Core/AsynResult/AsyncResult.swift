//
//  AsyncResult.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/8/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import Foundation

enum AsyncResult<T> {
    case success(data: T)
    case failure(error: AsyncError)
}

extension AsyncResult where T == Void {
    static var success: AsyncResult {
        return .success(data: ())
    }
}

struct AsyncError {
    enum ErrorType {
        case system
        case validation([String])
    }
    
    let code: String?
    let title: String
    let description: String?
    let type: ErrorType
    
    init(code: String? = nil, title: String, description: String? = nil, errorType: ErrorType = .system) {
        self.code = code
        self.title = title
        self.description = description
        self.type = errorType
    }
}

extension AsyncError {
    static var unexpected: AsyncError {
        return AsyncError(title: "please try again")
    }
    static var emailVerificationFailed: AsyncError {
        return AsyncError(title: "email or pasword is wrong!")
    }
}
