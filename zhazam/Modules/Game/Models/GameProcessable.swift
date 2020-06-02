//
//  GameProcessable.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol GameProcessable {
    var delegate: GameProcessDelegate? { get set }
    var game: Gaming { get set }
    
    func loadGame()
    func pause()
    func resume()
    func restart()
    func update(word: String)
}

extension GameProcessable {
    func pause() {
        game.pause()
    }
    func update(word: String) {
        game.update(word: word)
    }
    func restart() {
        game.restart()
    }
}
