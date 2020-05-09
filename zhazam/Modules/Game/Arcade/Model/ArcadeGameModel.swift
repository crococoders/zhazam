//
//  ArcadeGameModel.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

final class ArcadeGameModel: GameProcessable {
    weak var delegate: GameProcessDelegate?
    var game: Gaming
    
    init(game: Gaming) {
        self.game = game
        self.game.delegate = self
    }
    
    func loadGame() {
        var text = "If you want to use a layout manager on a background thread. "
        text += text
        text += text
        game.text = text
        game.start()
    }
    
    func resume() {
        let location = game.correctWordsCount + (game.nextWord?.count ?? 0)
        delegate?.didResume(at: location)
        game.resume()
    }
}

extension ArcadeGameModel: GameDelegate {
    func didUpdate(text: NSMutableAttributedString) {
        delegate?.didUpdate(text: text)
    }
    
    func didUpdate(word: NSMutableAttributedString) {
        delegate?.didUpdate(word: word)
    }
    
    func didUpdateTime() {
        delegate?.didUpdate(score: game.time)
    }
    
    func didFinishText(with score: Int) {
        delegate?.didFinishText(with: score)
    }
    
    func didFinish() {
        let location = game.correctWordsCount + (game.nextWord?.count ?? 0)
        delegate?.didFinishWord(location: location)
    }
}
