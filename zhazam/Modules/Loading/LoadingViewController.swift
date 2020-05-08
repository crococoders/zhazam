//
//  LoadingViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 8/20/19.
//  Copyright © 2019 Nurbek Ismagulov. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    @IBOutlet private var percentageLabel: LoadingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        
        print(TokenGenerator.shared.getToken())
    }
    
    private func setupNavigation() {
        showLoading { [weak self] in
            guard let self = self else { return }
            UserDefaultsStorage.isOnboardingCompleted ? self.routeToMainScreen() : self.routeToOnboarding()
        }
    }
    
    private func routeToMainScreen() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let rootViewController = MenuViewController(storage: MainMenuStorage())
        window.rootViewController = UINavigationController(rootViewController: rootViewController)
        
        UIView.transition(with: window,
                          duration: 0.7,
                          options: .transitionFlipFromBottom,
                          animations: {},
                          completion: nil)
    }
    
    private func showLoading(completion: @escaping Callback) {
        percentageLabel.generateFakeLoading(completion: completion)
    }
    
    private func routeToOnboarding() {
        let pages = getPages()
        let viewController = OnboardingPageViewController(with: pages)
        viewController.modalPresentationStyle = .fullScreen

        self.present(viewController, animated: true, completion: nil)
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
