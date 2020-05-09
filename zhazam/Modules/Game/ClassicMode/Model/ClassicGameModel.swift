//
//  ClassicGameModel.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol GameProcessDelegate: AnyObject {
    func didUpdate(text: NSMutableAttributedString)
    func didUpdate(word: NSMutableAttributedString)
    func didUpdate(score: Int)
    func didFinishWord(location: Int)
    func didFinishText(with score: Int)
}

final class ClassicGameModel: GameProcessable {
    weak var delegate: GameProcessDelegate?
    var game: Gaming
    
    init(game: Gaming) {
        self.game = game
        self.game.delegate = self
    }
    
    func loadGame() {
        let text = "If you want to use a layout manager on a background thread."
        game.text = text
        game.start()
    }
}

extension ClassicGameModel: GameDelegate {
    func didUpdate(text: NSMutableAttributedString) {
        delegate?.didUpdate(text: text)
    }
    
    func didUpdate(word: NSMutableAttributedString) {
        delegate?.didUpdate(word: word)
    }
    
    func didUpdateTime() {
        delegate?.didUpdate(score: game.wpm)
    }
    
    func didFinishText(with score: Int) {
        delegate?.didFinishText(with: score)
    }
    
    func didFinish() {
        let location = game.correctWordsCount + (game.nextWord?.count ?? 0)
        delegate?.didFinishWord(location: location)
    }
}
