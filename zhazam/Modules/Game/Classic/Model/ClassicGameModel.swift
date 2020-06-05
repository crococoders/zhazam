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
    func didCompleteWord(location: Int)
    func didFinish(with score: Int)
    func didResume(at location: Int)
}

// swiftlint:disable line_length
final class ClassicGameModel: GameProcessable {
    weak var delegate: GameProcessDelegate?
    var game: Gaming
    
    init(game: Gaming) {
        self.game = game
        self.game.delegate = self
    }
    
    func loadGame() {
        let text = "The team recorded the keyboard strokes as the participants transcribed different sentences. The researchers were able to monitor their typing speed, errors and other factors linked to typing behavior."
        game.start(with: text)
    }
}

extension ClassicGameModel: GameDelegate {
    func didFinish(with score: Int) {
        delegate?.didFinish(with: score)
    }
    
    func didCompleteWord(_ location: Int) {
        delegate?.didCompleteWord(location: location)
    }
    
    func didResume(_ location: Int) {
        delegate?.didResume(at: location)
    }
    
    func didUpdate(text: NSMutableAttributedString) {
        delegate?.didUpdate(text: text)
    }
    
    func didUpdate(word: NSMutableAttributedString) {
        delegate?.didUpdate(word: word)
    }
    
    func didUpdate(score: Int) {
        delegate?.didUpdate(score: score)
    }
}
