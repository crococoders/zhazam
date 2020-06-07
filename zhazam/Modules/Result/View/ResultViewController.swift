//
//  ResultViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ResultViewController: UIViewController {
    private let score: Int
    private let type: GameType
    private let provider = ResultProvider()

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
        configureProvider()
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
        quitButton.setTitle("Exit".localized.lowercased(), for: .normal)
        restartButton.setTitle("Again".localized.lowercased(), for: .normal)
    }
    
    private func configureViews() {
        scoreLabel.text = "\(score)\(type.unit)"
        stateLabel.text = "GoodJob".localized.lowercased()
    }
    
    private func configureProvider() {
        provider.delegate = self
        provider.save(score: score, with: type)
    }
    
    @IBAction private func restartPressed(_ sender: UIButton) {
        guard var viewControllers = navigationController?.viewControllers else { return }
        let countDownController = CountdownViewController(type: type)
        viewControllers.removeLast(3)
        viewControllers.append(countDownController)
        
        navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    @IBAction private func quitPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension ResultViewController: ResultProviderDelegate {
    func didSetResult(_ result: GameResult?) {
        guard let percentage = result?.percentage else { return }
        percentageLabel.text = String.init(format: "BeatenPercentage".localized, percentage.formatted())
        UIView.animate(withDuration: 0.5) {
            self.percentageLabel.alpha = 1.0
        }
    }
}
