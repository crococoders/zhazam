//
//  OnboardingViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class OnboardingViewController: UIViewController {

    @IBOutlet private var stackView: UIStackView!
    private var index: Int
    private let page: OnboardingPage
    
    init(with page: OnboardingPage, index: Int) {
        self.page = page
        self.index = index
        
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureContent()
        hideKeyboardWhenTappedAround()
    }
    
    private func configureContent() {
        switch page.type {
        case .interfaceStyle:
            let horizontalView = ConfigurationView(key: "Lights".localized,
                                                        value: getInterfaceStyleString())
            horizontalView.onTap = { [weak self] in
                guard let self = self else { return }
                self.blinkBackground()
            }
            
            stackView.addArrangedSubview(horizontalView)
        case .finish:
            let onStart = { [weak self] in
                guard let self = self else { return }
                UserDefaultsStorage.isOnboardingCompleted = true
                self.routeToMainScreen()
            }
            let action = ["Start".localized.lowercased(): onStart]
            let viewModel = TitledTextViewModel(title: "LetsStart".localized,
                                                placeholder: "Start".localized.lowercased(),
                                                actions: action)
            let titledTextView = TitledTextView(viewModel: viewModel)
            
            stackView.addArrangedSubview(titledTextView)
        }
    }
    
    func getIndex() -> Int {
        return index
    }
    
    private func getInterfaceStyleString() -> String {
        if darkModeEnabled() {
            return "Off".localized.lowercased()
        }
        return "On".localized.lowercased()
    }
    
    private func darkModeEnabled() -> Bool {
        guard #available(iOS 12.0, *),
            self.traitCollection.userInterfaceStyle == .dark else {
            return false
        }
        
        return true
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard let view = stackView.arrangedSubviews.first as? ConfigurationView,
            page.type == .interfaceStyle else { return }
        view.value = getInterfaceStyleString()
    }
}
