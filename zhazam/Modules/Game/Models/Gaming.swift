//
//  Gaming.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol Gaming {
    var delegate: GameDelegate? { get set }
    
    func start(with text: String)
    func pause()
    func resume()
    func restart()
    func update(word: String)
    func finish()
}
