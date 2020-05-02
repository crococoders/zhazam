//
//  RandomGenerator.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class RandomGenerator {
    static func generateBetween(_ lower: Int, _ upper: Int) -> Int {
        return Int.random(in: lower...upper)
    }
}
