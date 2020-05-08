//
//  ClassicModeViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ClassicModeViewController: UIViewController {
    
    private var keyboardObserver: KeyboardStateObservering = KeyboardStateObserver()
    private var gameProcess = ClassicGameModel(game: Game(type: .classic))

    @IBOutlet private var textView: UITextView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var textFieldBottomConstraint: NSLayoutConstraint!
    private var barButtonItem = GameBarButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField()
        configureKeyboardObserving()
        setupGameModel()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardObserver.startListening()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        keyboardObserver.stopListening()
    }
    
    private func setupNavigationBar() {
        let rightButtonItem = UIBarButtonItem(customView: barButtonItem)
        navigationItem.rightBarButtonItem = rightButtonItem
        rightButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        guard let customView = rightButtonItem.customView else { return }
        NSLayoutConstraint.activate([
            customView.heightAnchor.constraint(equalToConstant: 70),
            customView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func configureTextField() {
        textField.becomeResponder()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func configureKeyboardObserving() {
        keyboardObserver.willShow = { [weak self] rect, _, curve in
            self?.updateTextFieldConstraints(offset: rect.height - 12, curve: curve)
        }
        
        keyboardObserver.willHide = { [weak self] _, _, curve in
            self?.updateTextFieldConstraints(offset: 12, curve: curve)
        }
    }
    
    private func setupGameModel() {
        gameProcess.delegate = self
        gameProcess.loadGame()
    }
    
    private func updateTextFieldConstraints(offset: CGFloat, curve: UInt) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: UIView.AnimationOptions(rawValue: curve),
            animations: { [weak self] in
                self?.textFieldBottomConstraint.constant = offset
                self?.view.layoutIfNeeded()
        })
    }
    
    private func scroll(to location: Int) {
        let range = NSRange(location: location, length: 0)
        let rect = textView.layoutManager.boundingRect(forGlyphRange: range,
                                                       in: textView.textContainer)
        textView.setContentOffset(CGPoint(x: 0, y: rect.origin.y + 8.0), animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        gameProcess.update(word: text)
    }
}

extension ClassicModeViewController: ClassicGameDelegate {
    func didUpdate(text: NSMutableAttributedString) {
        textView.attributedText = text
    }
    
    func didUpdate(word: NSMutableAttributedString) {
        textField.attributedText = word
    }
    
    func didFinishWord(location: Int) {
        textField.text = ""
        scroll(to: location)
    }
    
    func didUpdate(wpm: Int) {
        barButtonItem.setScore(score: wpm)
    }
}
