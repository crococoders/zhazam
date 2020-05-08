//
//  ClassicGameModel.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol ClassicGameDelegate: AnyObject {
    func didUpdate(text: NSMutableAttributedString)
    func didUpdate(word: NSMutableAttributedString)
    func didUpdate(wpm: Int)
    func didFinishWord(location: Int)
}

final class ClassicGameModel {
    weak var delegate: ClassicGameDelegate?
    private var game: Gaming
    
    init(game: Gaming) {
        self.game = game
        self.game.delegate = self
    }
    
    func loadGame() {
        let text = "If you want to use a layout manager on a background thread"
        game.text = text
        game.start()
    }
    
    func pause() {
        game.pause()
    }
    
    func resume() {
        game.resume()
    }
    
    func update(word: String) {
        game.update(word: word)
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
        delegate?.didUpdate(wpm: game.wpm)
    }
    
    func didFinishText() {
        
    }
    
    func didFinish(_ word: String) {
        let location = game.correctWordsCount + (game.nextWord?.count ?? 0)
        delegate?.didFinishWord(location: location)
    }
}
