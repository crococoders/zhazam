//
//  Game.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol GameDelegate: AnyObject {
    func didUpdateTime()
    func didFinishText(with wpm: Int)
    func didFinish()
    func didUpdate(text: NSMutableAttributedString)
    func didUpdate(word: NSMutableAttributedString)
}

final class Game {
    private enum Constants {
        static let delimeter = " "
        static let defaultAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: R.color.defaultGray()!,
                                                                       .font: R.font.helveticaNeueBold(size: 36)!]
    }
    
    weak var delegate: GameDelegate?
    var time = 0
    var correctWordsCount = 0
    var text: String? {
        didSet {
            guard let text = text else { return }
            words = text.components(separatedBy: Constants.delimeter)
            attributedText = NSMutableAttributedString(string: text, attributes: Constants.defaultAttributes)
            delegate?.didUpdate(text: attributedText!)
        }
    }
    private var type: GameType
    private var timer = Timer()
    private var words: [String] = []
    private var index = 0
    private var lastUpdatedWord = ""
    private var isLastWord: Bool {
        return index == words.count - 1
    }
    private var attributedText: NSMutableAttributedString?
    
    init(type: GameType) {
        self.type = type
    }
    
    private func attribute(word: String) {
        guard let unwrappedWord = words[safe: index] else { return }
        let correctLettersLength = word.commonPrefix(with: unwrappedWord).count
        let attributedWord = NSMutableAttributedString(string: word)
        
        attributedWord.addAttribute(.foregroundColor, value: R.color.textColor()!,
                                    range: NSRange(location: 0, length: correctLettersLength))
        attributedWord.addAttribute(.foregroundColor, value: R.color.defaultRed()!,
                                    range: NSRange(location: correctLettersLength,
                                                   length: word.count - correctLettersLength))
        delegate?.didUpdate(word: attributedWord)
    }
    
    private func attribute(text: NSMutableAttributedString?, with word: String) {
        guard let unwrappedWord = words[safe: index], let attributedText = attributedText else { return }
        
        let correctLettersLength = word.commonPrefix(with: unwrappedWord).count
        
        attributedText.addAttribute(.foregroundColor, value: R.color.textColor()!,
                                    range: NSRange(location: correctWordsCount, length: correctLettersLength))
        attributedText.addAttribute(.foregroundColor, value: R.color.defaultRed()!,
                                    range: NSRange(location: correctLettersLength + correctWordsCount,
                                                   length: word.count - correctLettersLength))
        let location = correctWordsCount + word.count
        let length = lastUpdatedWord.count - word.count
        if lastUpdatedWord.count > word.count && location + length < attributedText.length {
            attributedText.addAttribute(.foregroundColor, value: R.color.defaultGray()!,
            range: NSRange(location: correctWordsCount + word.count, length: length))
        }
        delegate?.didUpdate(text: attributedText)
        
    }
    
    private func getCurrentWord() -> String? {
        guard let unwrappedWord = words[safe: index] else { return nil }
        var currentWord = unwrappedWord
        if (type == .classic || type == .arcade) && !isLastWord {
            currentWord += Constants.delimeter
        }
        return currentWord
    }
    
    @objc private func increaseTime() {
        time += 1
        delegate?.didUpdateTime()
    }
}

extension Game: Gaming {
    var nextWord: String? {
        return words[safe: index + 1]
    }
    
    var wpm: Int {
        Int((Double(index + 1) / Double(time)) * 60)
    }
    
    func update(word: String) {
        guard let currentWord = getCurrentWord() else { return }
        attribute(word: word)
        attribute(text: attributedText, with: word)
        if word == currentWord {
            isLastWord ? delegate?.didFinishText(with: wpm) : delegate?.didFinish()
            index += 1
            lastUpdatedWord = ""
            correctWordsCount += currentWord.count
        }
        lastUpdatedWord = word
    }
    
    func start() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(increaseTime),
                                     userInfo: nil, repeats: true)
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func resume() {
        timer.fire()
    }
}
