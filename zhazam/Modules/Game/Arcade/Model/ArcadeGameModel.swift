//
//  ArcadeGameModel.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

// swiftlint:disable line_length
final class ArcadeGameModel: GameProcessable {
    weak var delegate: GameProcessDelegate?
    var game: Gaming
    
    init(game: Gaming) {
        self.game = game
        self.game.delegate = self
    }
    
    func loadGame() {
        let text = "This younger generation grew up with touch screen devices and smartphones, so this is not such a surprise. Older generations have been typing on keyboards and smartphones for longer, however, due to the high turnover and changes in devices over the years, their ability to type as quickly is not on par with teenagers. The main finding, though, is that typing speeds between texting and keyboard typing is decreasing in general"
        game.start(with: text)
    }
}

extension ArcadeGameModel: GameDelegate {
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
    
    func didFinish(with score: Int) {
        delegate?.didFinish(with: score)
    }
}
