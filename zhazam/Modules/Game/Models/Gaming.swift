//
//  Gaming.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol Gaming {
    func start()
    func pause()
    func resume()
    func update(word: String)
    var wpm: Int { get }
    var time: Int { get }
    var text: String? { get set }
    var correctWordsCount: Int { get }
    var nextWord: String? { get }
    var delegate: GameDelegate? { get set }
}
