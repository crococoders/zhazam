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
        static let maxAvailablePercentage: Int = 10
        static let minDelayTime: TimeInterval = 0.6
        static let maxDelayTime: TimeInterval = 0.8
    }
    
    @IBOutlet private var percentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    private func setupNavigation() {
        generateFakeLoading(from: generateRandomNumber(from: 0, to: 2)) { [weak self] in
            guard let self = self else { return }
            UserDefaultsStorage.isOnboardingCompleted ? self.routeToMainScreen() : self.routeToOnboarding()
        }
    }
    
    private func routeToMainScreen() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.rootViewController = UINavigationController(rootViewController: MenuViewController())
        
        UIView.transition(with: window,
                          duration: 0.7,
                          options: .transitionFlipFromBottom,
                          animations: {},
                          completion: nil)
    }
    
    private func routeToOnboarding() {
        let pages = getPages()
        let viewController = OnboardingPageViewController(with: pages)
        viewController.modalPresentationStyle = .fullScreen

        self.present(viewController, animated: true, completion: nil)
    }

    private func generateFakeLoading(from percentage: Int, completion: @escaping Callback) {
        guard percentage < Constants.maxAvailablePercentage else {
            completion()
            return
        }
        
        let randomNumber = generateRandomNumber(from: percentage,
                                                to: Constants.maxAvailablePercentage)
        
        setPercentageLabel(number: randomNumber)
        
        let delayTime = generateRandomDelay()
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) { [weak self] in
            self?.generateFakeLoading(from: randomNumber, completion: completion)
        }
    }
    
    private func generateRandomNumber(from lower: Int, to upper: Int) -> Int {
        return Int.random(in: lower...upper)
    }
    
    private func generateRandomDelay() -> TimeInterval {
        return TimeInterval.random(in: Constants.minDelayTime...Constants.maxDelayTime)
    }
    
    private func setPercentageLabel(number: Int) {
        percentageLabel.text = number < Constants.maxAvailablePercentage ? "0\(number)0." : "\(number)0."
    }
    
    private func getPages() -> [OnboardingPage] {
        let pages = OnboardingType.allCases.map { type -> OnboardingPage in
            return OnboardingPage(type: type)
        }

        return pages
    }
}

extension UserDefaultsStorage {
    @UserDefaultsBacked(key: "isOnboardingCompleted", defaultValue: false)
    static var isOnboardingCompleted: Bool
}
