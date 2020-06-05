//
//  ClassicModeViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ClassicModeViewController: UIViewController {
    
    private var keyboardObserver: KeyboardStateObservable = KeyboardStateObserver()
    private var gameProcess: GameProcessable = ClassicGameModel(game: Game(type: .classic))

    @IBOutlet private var textView: UITextView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var textFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var scoreView: GameScoreView!
    @IBOutlet private var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureKeyboardObserving()
        setupGameModel()
        setupTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardObserver.startListening()
        textField.becomeResponder()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        keyboardObserver.stopListening()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func configureKeyboardObserving() {
        keyboardObserver.willShow = { [weak self] rect, _, curve in
            guard let self = self else { return }
            self.updateTextFieldConstraints(offset: rect.height - 12, curve: curve)
        }
        
        keyboardObserver.willHide = { [weak self] _, _, curve in
            guard let self = self else { return }
            self.updateTextFieldConstraints(offset: 12, curve: curve)
        }
    }
    
    private func setupTextView() {
        textView.contentInset = .zero
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0.0
    }
    
    private func setupGameModel() {
        gameProcess.delegate = self
        gameProcess.loadGame()
    }
    
    private func updateTextFieldConstraints(offset: CGFloat, curve: UInt) {
        textFieldBottomConstraint.constant = offset
    }
    
    private func scroll(to location: Int) {
        let range = NSRange(location: location, length: 0)
        let rect = textView.layoutManager.boundingRect(forGlyphRange: range, in: textView.textContainer)
        textView.setContentOffset(CGPoint(x: 0, y: rect.origin.y), animated: true)
    }
    
    @IBAction private func textFieldDidChange(_ sender: PrimaryTextField) {
        guard let text = sender.text else { return }
        gameProcess.update(word: text)
    }
    
    @IBAction private func menuButtonPressed(_ sender: UIButton) {
        gameProcess.pause()
        let viewModel = setupMenuViewModel()
        let viewController = ChoiceViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false, completion: nil)
    }
    
    private func setupMenuViewModel() -> TitledTextViewModel {
        let onExit = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        let onRestart = { [weak self] in
            guard let self = self else { return }
            self.gameProcess.restart()
        }
        let actions = [R.string.localizable.exit().lowercased(): onExit,
                       R.string.localizable.restart().lowercased(): onRestart]
        let onDismiss: Callback = { [weak self] in
            guard let self = self else { return }
            self.textField.becomeResponder()
            self.gameProcess.resume()
            
        }
        let viewModel = TitledTextViewModel(title: R.string.localizable.exitOrRestartQuestion(),
                                            placeholder: R.string.localizable.exitOrRestart(),
                                            actions: actions,
                                            onDismiss: onDismiss)
        return viewModel
    }
}

extension ClassicModeViewController: GameProcessDelegate {
    func didCompleteWord(location: Int) {
        textField.text = ""
        scroll(to: location)
    }
    
    func didFinish(with score: Int) {
        let viewController = ResultViewController(score: score, type: .classic)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didResume(at location: Int) {
        scroll(to: location)
    }
    
    func didUpdate(text: NSMutableAttributedString) {
        textView.attributedText = text
    }
    
    func didUpdate(word: NSMutableAttributedString) {
        textField.attributedText = word
    }
    
    func didUpdate(score: Int) {
        scoreView.setScore(score, type: .classic)
    }
}
