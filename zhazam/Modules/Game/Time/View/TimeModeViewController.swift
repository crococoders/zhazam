//
//  TimeModeViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 6/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class TimeModeViewController: UIViewController, Reusable {

    private var keyboardObserver: KeyboardStateObservable = KeyboardStateObserver()
    private var words: [String] = []
    private var gameProcess = TimeGameModel()
    
    @IBOutlet private var scoreView: GameScoreView!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var textField: PrimaryTextField!
    @IBOutlet private var textFieldBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardObserving()
        setupCollectionView()
        setupGameModel()
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
    
    @IBAction private func textFieldDidChange(_ sender: PrimaryTextField) {
        guard let text = sender.text else { return }
        gameProcess.update(word: text)
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
    
    private func updateTextFieldConstraints(offset: CGFloat, curve: UInt) {
        textFieldBottomConstraint.constant = offset
    }
    
    private func setupGameModel() {
        gameProcess.delegate = self
        gameProcess.loadGame()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellClass: TimeModeCell.self)
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

extension TimeModeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        words.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TimeModeCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: words[indexPath.row])
        return cell
    }
}

extension TimeModeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.height /= 3
        return collectionViewSize
    }
}

extension TimeModeViewController: TimeModeDelegate {
    func didUpdateText(_ text: NSMutableAttributedString, at index: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: index,
                                                                  section: 0)) as? TimeModeCell else { return }
        cell.configure(with: text)
    }
    
    func didUpdateWord(_ word: NSMutableAttributedString) {
        textField.attributedText = word
    }
    
    func didLoadText(words: [String]) {
        self.words = words
    }
    
    func didFinish(with score: Int) {
        let viewController = ResultViewController(score: score, type: .time)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didCompleteWord(at index: Int) {
        textField.text = ""
        collectionView.scrollToItem(at: IndexPath(row: index + 1, section: 0), at: .top, animated: true)
    }
    
    func didUpdateTime(_ time: Int) {
        scoreView.setScore(time, type: .time)
    }
    
}
