//
//  Game.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol GameDelegate: class {
    func didFinish(with score: Int)
    func didCompleteWord(_ location: Int)
    func didUpdate(score: Int)
    func didUpdate(text: NSMutableAttributedString)
    func didUpdate(word: NSMutableAttributedString)
    func didResume(_ location: Int)
}

private enum Constants {
    static let delimeter = " "
    static let defaultAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: R.color.defaultGray()!,
                                                                   .font: R.font.helveticaNeueBold(size: 36)!]
}

final class Game {
    weak var delegate: GameDelegate?
    var correctWordsCount = 0
    private var time = 0
    private var attributedText: NSMutableAttributedString?
    private var type: GameType
    private var timer: Timer?
    private var words: [String] = []
    private var index = 0
    private var lastUpdatedWord = ""
    private var isLastWord: Bool {
        return index == words.count - 1
    }
    private var score: Int {
        switch type {
        case .classic, .time:
            return wpm
        case .arcade:
            return time
        }
    }
    private var wpm: Int {
        Int((Double(index + 1) / Double(time)) * 60)
    }
    
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
        if correctWordsCount + word.count <= text?.length ?? 0 {
            attributedText.addAttribute(.foregroundColor, value: R.color.defaultRed()!,
                                        range: NSRange(location: correctLettersLength + correctWordsCount,
                                                       length: word.count - correctLettersLength))
        }
        let location = correctWordsCount + word.count
        let length = lastUpdatedWord.count - word.count
        if lastUpdatedWord.count > word.count && location + length <= text?.length ?? 0 {
            attributedText.addAttribute(.foregroundColor, value: R.color.defaultGray()!,
            range: NSRange(location: correctWordsCount + word.count, length: length))
        }
        delegate?.didUpdate(text: attributedText)
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(increaseTime),
                                     userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc
    private func increaseTime() {
        time += 1
        delegate?.didUpdate(score: score)
    }
}

extension Game: Gaming {
    func update(word: String) {
        attribute(word: word)
        attribute(text: attributedText, with: word)
        lastUpdatedWord = word
        completeWordIfNeeded(word)
    }
    
    private func completeWordIfNeeded(_ word: String) {
        guard let currentWord = getDelimiteredCurrentWord(), word == currentWord else { return }
        lastUpdatedWord = ""
        correctWordsCount += currentWord.count
        if isLastWord {
            stopTimer()
            delegate?.didFinish(with: score)
        } else {
            delegate?.didCompleteWord(correctWordsCount)
        }
        index += 1
    }
    
    private func getDelimiteredCurrentWord() -> String? {
        guard var currentWord = words[safe: index] else { return nil }
        if (type == .classic || type == .arcade) && !isLastWord {
            currentWord += Constants.delimeter
        }
        return currentWord
    }
    
    func start(with text: String) {
        words = text.components(separatedBy: Constants.delimeter)
        attributedText = NSMutableAttributedString(string: text, attributes: Constants.defaultAttributes)
        delegate?.didUpdate(text: attributedText!)
        startTimer()
    }
    
    func pause() {
        stopTimer()
    }
    
    func finish() {
        stopTimer()
        delegate?.didFinish(with: score)
    }
    
    func resume() {
        startTimer()
        delegate?.didResume(correctWordsCount)
    }
    
    func restart() {
        time = 0
        index = 0
        lastUpdatedWord = ""
        correctWordsCount = 0
        startTimer()
        let range = NSRange(location: 0, length: attributedText?.string.count ?? 0)
        attributedText?.setAttributes(Constants.defaultAttributes, range: range)
        delegate?.didUpdate(text: attributedText!)
        delegate?.didUpdate(word: NSMutableAttributedString(string: ""))
    }
}
