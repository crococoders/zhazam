//
//  ResultViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

enum GameState {
    case finished, lost
}

final class ResultViewController: UIViewController {
    
    private let score: Int
    private let type: GameType

    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var stateLabel: UILabel!
    @IBOutlet private var percentageLabel: UILabel!
    @IBOutlet private var restartButton: UIButton!
    @IBOutlet private var quitButton: UIButton!
    
    init(score: Int, type: GameType) {
        self.score = score
        self.type = type
        
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizeViews()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func localizeViews() {
        quitButton.setTitle(R.string.localizable.exit(), for: .normal)
        restartButton.setTitle(R.string.localizable.again().lowercased(), for: .normal)
    }
    
    private func configureViews() {
        scoreLabel.text = "\(score)\(type.unit)"
        stateLabel.text = R.string.localizable.goodJob().lowercased()
        
    }
    @IBAction private func restartPressed(_ sender: UIButton) {
        guard var viewControllers = navigationController?.viewControllers else { return }
        let countDownController = CountdownViewController(type: type)
        viewControllers.removeLast(3)
        viewControllers.append(countDownController)
        
        navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    @IBAction private func quitPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
