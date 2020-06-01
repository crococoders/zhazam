//
//  ArcadeModeViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ArcadeModeViewController: UIViewController {

    private var keyboardObserver: KeyboardStateObservable = KeyboardStateObserver()
    private var gameProcess: GameProcessable = ArcadeGameModel(game: Game(type: .arcade))
    
    private var textViewVerticalOffset: CGFloat = 0
    // TODO: - refactor models, transfer data to models
    private var currentLocation: Int = 0
    private var score: Int = 0
    
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var textField: PrimaryTextField!
    @IBOutlet private var textFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var menuButton: UIButton!
    @IBOutlet private var scoreView: GameScoreView!
    private lazy var gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGradient()
        configureKeyboardObserving()
        setupGameModel()
        setupDisplayLink()
        textView.textContainerInset = UIEdgeInsets(top: 200, left: 0,
                                                   bottom: 0, right: 0)
    }
    
    private var speed: CGFloat = 1
    private var displayLink: CADisplayLink?
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateGradientFrame()
    }
    
    private func configureGradient() {
        gradient.colors = [UIColor.clear.cgColor, R.color.background()!.cgColor,
                           R.color.background()!.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 0.2, 0.8, 1]
        gradient.delegate = self
        textView.layer.mask = gradient
    }
    
    private func setupDisplayLink() {
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(step(displaylink:)))
        displayLink?.preferredFramesPerSecond = 15
        displayLink?.add(to: .current, forMode: RunLoop.Mode.default)
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

    private func setupGameModel() {
        gameProcess.delegate = self
        gameProcess.loadGame()
    }
        
    private func updateTextFieldConstraints(offset: CGFloat, curve: UInt) {
        textFieldBottomConstraint.constant = offset
    }
    
    @objc func step(displaylink: CADisplayLink) {
        if textView.visibleRange?.location ?? 0 > currentLocation {
            pause()
            routeToResult()
            
        }
        let seconds = displaylink.targetTimestamp - displaylink.timestamp
        textViewVerticalOffset = textView.contentOffset.y + speed * CGFloat(seconds) * 10
        textView.setContentOffset(CGPoint(x: 0,
                                          y: textViewVerticalOffset),
                                  animated: false)
        updateGradientFrame()
    }
    
    @IBAction func textFieldChanged(_ sender: PrimaryTextField) {
        guard let text = sender.text else { return }
        gameProcess.update(word: text)
    }
    
    @IBAction private func menuButtonPressed(_ sender: UIButton) {
        pause()
        let viewModel = setupMenuViewModel()
        let viewController = ChoiceViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: false, completion: nil)
    }
    
    private func pause() {
        gameProcess.pause()
        displayLink?.invalidate()
        displayLink = nil
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
    
    private func routeToResult() {
        let viewController = ResultViewController(score: score, type: .arcade)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ArcadeModeViewController: GameProcessDelegate {
    func didResume(at location: Int) {
        textView.setContentOffset(CGPoint(x: 0, y: textViewVerticalOffset), animated: false)
        setupDisplayLink()
    }
    
    func didUpdate(text: NSMutableAttributedString) {
        textView.attributedText = text
    }
    
    func didUpdate(word: NSMutableAttributedString) {
        textField.attributedText = word
    }
    
    func didFinishWord(location: Int) {
        textField.text = ""
        currentLocation = location
    }
    
    func didUpdate(score: Int) {
        speed += score % 5 == 0 ? 0.2 : 0
        self.score = score
        scoreView.setScore(score: score, type: .arcade)
    }
    
    func didFinishText(with score: Int) {
        self.score = score
        routeToResult()
    }
}

extension ArcadeModeViewController: UIScrollViewDelegate, CALayerDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateGradientFrame()
    }

    func action(for layer: CALayer, forKey event: String) -> CAAction? {
        NSNull()
    }
    private func updateGradientFrame() {
        gradient.frame = CGRect(x: 0, y: textView.contentOffset.y,
                                width: textView.bounds.width,
                                height: textView.bounds.height)
    }
}
