//
//  TimeGameModel.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 6/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol TimeModeDelegate: class {
    func didLoadText(words: [String])
    func didFinish(with score: Int)
    func didCompleteWord(at index: Int)
    func didUpdateText(_ text: NSMutableAttributedString, at index: Int)
    func didUpdateWord(_ word: NSMutableAttributedString)
    func didUpdateTime(_ time: Int)
}

private enum Constants {
    static let delimeter = " "
    static let defaultAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: R.color.defaultGray()!,
                                                                   .font: R.font.helveticaNeueBold(size: 36)!]
}

// swiftlint:disable line_length
final class TimeGameModel {
    weak var delegate: TimeModeDelegate?
    
    func loadGame() {
        let text = "alteration insipidity impression traveling reasonable motionless regard warmth unable sudden garden ladies kept hung size spot started several mistake joy painful removed reached end. State burst think end are its arrived off she elderly say beloved him affixed noisier yet course regard hardly prepare nothing blushes brought gravity pasture limited evening wicket around beauty say she frankness resembled say not new smallness you discovery noisier yet shyness weather ten colonel too him himself engaged husband pursuit musical man age but him determine consisted therefore dinner beyond regret wished branch remain bed but expect suffer little repair comfort write conduct prevent manners celebrate discretion her collect occasional answer bachelor occasion offend concerns supply worthy warm branch voice try known though wish merits alone visit use these smart rooms ham waiting enjoy placing inquiry advance and civility not absolute put continue overcame nurbek almost unable put piqued talk likely house her met any nor may through resolve entered cause tried shade happy agree assurance wicket longer admire barton vanity itself preferred sportsmen engrossed park gate sell they west hard for the abode stuff noisy manor blush yet the colonel between removed years use place decay sex worth drift age lasting out article express fortune demands own charmed about are money ask how seven meant balls doubt small purse required his you put the outlived answered position pleasure exertion believed provided all led out world these music while asked paid mind even sons does door attended overcame repeated perceive think style child servants moreover sensible possible play they miss give words style since world leaf snug need way own uncommonly traveling now acceptance bed compliment solicitude dissimilar admiration terminated contrasted advantages entreaties apartments limits far yet turned highly repair parish talked six draw fond rank form nor the day eat sure calm much most long mean able rent long commonly announcing melancholy mirth learn given secure shy length all twenty denote felicity packages answered opinions juvenile attended desirous raptures declared diverted confined collected instantly remaining certainly necessary over walk dull into son boy door went new happiness commanded daughters handsome declared received extended vicinity subjects into miss over been late pain only week bore boy what fat case left use match round scale now sex style far times your past much unfeeling rapturous discovery exquisite reasonably impression terminated old pleasure required removing elegance him had down she bore sing saw calm high game gate west face shed great but music too old found arose perceived end knowledge certainly day sweetness why cordially ask quick six seven offer see among handsome met debating sir dwelling age material style lived worse dried offered related visitor private removed moderate subjects distance sitting mistake towards his few country ask you delighted two rapturous six depending objection happiness something off nay impossible dispatched partiality unaffected adapted put ham cordial ladies talked may shy basket narrow see she distrusts questions sportsmen tolerably pretended neglected earnestly sex scale sir style truth ought passage its ten led hearted removal cordial preference any astonished unreserved prosperous understood conviction nurbek uncommonly supposing resolve breakfast perfectly drew hill from valley twenty direct departure defective arranging rapturous did believing him all had supported Family months lasted simple set nature vulgar him picture for attempt joy excited ten carried manner talk how from they fine give rich they age and draw like improve end distrust may instantly was household applaud incommode why kept very ever home considered sympathize ten uncommonly occasional assistance sufficient not letter become tended active enable vicinity relation sensible sociable surprise screen would have been ruined whole lot worse than now least now having some fun may indulgence difficult ham can put especially bring remember for supplied why confined principle did she procuring extensive believing add weather adapted prepare calling these wrong which there smile front fruit enjoy whose table cultivated occasional old her unpleasing unpleasant against pasture cover view started enjoyed settled respect spirits civilly outlived insisted procured improve paid hill fine ten now love even leaf supplied feeling dissuade recurred offer collect excellence her sixteen end ashamed cottage yet reached get hearing invited Resources ourselves sweetness perfectly warmly warmth six any wisdom family giving pull beauty chat highly blessing appetite domestic did judgment rendered entirely highly indeed had garden not decisively friendship collect affixed husband female brother garret proceed least child who seven happy yet balls young discovery sweet principle course shame bed one excellent sentiment surround friend dispatch connection produce besides hastily pleased bore less when had and shed hope met party gravity husband sex please kind next feel held walk last own loud and knew give gay four sentiment motion principles  nurbek matter future lovers desire marked boy use chamber reached nothing delightful remarkable announce themselves about terms voice equal would found seems the particular friendship one sufficient terminated frequently themselves more shed went roof loud case delay music lived noise beyond genius really enough passed pray mantis you know how they mate the male  sneak the female and bite off head and rest his body will keep mating and when they done she eat rest him ready are you what know you ready for eight hundred years have train own counsel will keep who train must have the deepest commitment the most serious mind this one long time have watched all life has looked away the future the horizon never his mind where was that guy was hurting you come out when you did hurt lot worse probably nothing happened him everybody did see dancing with him all night they made out like asked for life how live without ones love time still turns pages the book burned place and time always mind have much say but you are far away must wait for the sunrise must think new life must give when dawn comes tonight memory too and new day will begin burnt out ends smoky days preference excellence literature surrounded insensible indulgence admiration remarkable suspicion neglected resolve agreement perceived"
        delegate?.didLoadText(words: text.components(separatedBy: " "))
        start(with: text)
    }
    
    private var time = 60
    private var attributedText: NSMutableAttributedString?
    private var timer: Timer?
    private var words: [String] = []
    private var index = 0
    private var lastUpdatedWord = ""
    private var isLastWord: Bool {
        return index == words.count - 1
    }
    private var score: Int {
        return index+1
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
        delegate?.didUpdateWord(attributedWord)
    }
    
    private func attribute(text: NSMutableAttributedString?, with word: String) {
        guard let unwrappedWord = words[safe: index], let attributedText = text else { return }
        
        let correctLettersLength = word.commonPrefix(with: unwrappedWord).count
        
        attributedText.addAttribute(.foregroundColor, value: R.color.textColor()!,
                                    range: NSRange(location: 0, length: correctLettersLength))
        let isInRange = word.count <= attributedText.length
        let redRange = isInRange ? word.count - correctLettersLength : attributedText.length - correctLettersLength
        attributedText.addAttribute(.foregroundColor, value: R.color.defaultRed()!,
        range: NSRange(location: correctLettersLength,
                       length: redRange))
        let location = word.count
        let length = lastUpdatedWord.count - word.count
        if lastUpdatedWord.count > word.count && location + length <= attributedText.length {
            attributedText.addAttribute(.foregroundColor, value: R.color.defaultGray()!,
                                        range: NSRange(location: word.count, length: length))
        }
        delegate?.didUpdateText(attributedText, at: index)
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
        time -= 1
        delegate?.didUpdateTime(time)
        if time == 0 {
            stopTimer()
            delegate?.didFinish(with: score)
        }
    }
    
    func update(word: String) {
        attribute(word: word)
        let text = NSMutableAttributedString(string: words[index])
        attribute(text: text, with: word)
        lastUpdatedWord = word
        completeWordIfNeeded(word)
    }
    
    private func completeWordIfNeeded(_ word: String) {
        guard let currentWord = getDelimiteredCurrentWord(), word == currentWord else { return }
        lastUpdatedWord = ""
        if isLastWord {
            stopTimer()
            delegate?.didFinish(with: score)
        } else {
            let location = index
            delegate?.didCompleteWord(at: location)
        }
        index += 1
    }
    
    private func getDelimiteredCurrentWord() -> String? {
        guard let currentWord = words[safe: index] else { return nil }
        return currentWord
    }
    
    func start(with text: String) {
        words = text.components(separatedBy: Constants.delimeter)
        attributedText = NSMutableAttributedString(string: text, attributes: Constants.defaultAttributes)
        delegate?.didUpdateText(attributedText!, at: index)
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
//        delegate?.didResume(correctWordsCount)
    }
    
    func restart() {
        time = 60
        index = 0
        lastUpdatedWord = ""
        startTimer()
        let range = NSRange(location: 0, length: attributedText?.string.count ?? 0)
        attributedText?.setAttributes(Constants.defaultAttributes, range: range)
        delegate?.didUpdateText(attributedText!, at: index)
        delegate?.didUpdateWord(NSMutableAttributedString(string: ""))
    }
}
