//
//  LoadingViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 8/20/19.
//  Copyright © 2019 Nurbek Ismagulov. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {
    private enum Constants {
        static let timerDelay: TimeInterval = 0.08
        static let minGrow: Int = 1
        static let maxGrow: Int = 10
        static let maxSupportedValue: Int = 100
        static let completionDelay = 0.1
    }
    
    @IBOutlet private var percentageLabel: LoadingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    private func setupNavigation() {
        showLoading { [weak self] in
            guard let self = self else { return }
            self.performAnimatedTransition()
        }
    }
    
    private func performAnimatedTransition() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = UINavigationController(rootViewController: MenuViewController())
        
        UIView.transition(with: window,
                          duration: 0.7,
                          options: .transitionFlipFromBottom,
                          animations: {},
                          completion: nil)
    }
    
    private func showLoading(completion: @escaping() -> Void) {
        percentageLabel.generateFakeLoading(completion: completion)
    }
}
