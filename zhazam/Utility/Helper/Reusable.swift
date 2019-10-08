//
//  Reusable.swift
//  zhazam
//
//  Created by Almas Zainoldin on 10/8/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import Foundation

protocol Reusable {
    var identifier: String { get }
}

extension Reusable {
    var identifier: String {
        return String(describing: self)
    }
}
