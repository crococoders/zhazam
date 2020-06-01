//
//  Result.swift
//  zhazam
//
//  Created by Beknar Danabek on 07/08/2018.
//  Copyright © 2018 crococoders. All rights reserved.
//

import Foundation

enum Result<Error> {
    case success
    case failure(Error)
}
