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
        let text = "This younger generation grew up with touch screen devices and smartphones, so this isn't such a surprise. Older generations have been typing on keyboards and smartphones for longer, however, due to the high turnover and changes in devices over the years, their ability to type as quickly is not on par with teenagers. The main finding, though, is that typing speeds between texting and keyboard typing is decreasing in general"
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
