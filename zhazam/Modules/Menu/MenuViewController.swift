//
//  MenuViewController.swift
//  zhazam
//
//  Created by Sanzhar Alim on 4/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {
    
    @IBOutlet private var logoView: LogoView!
    @IBOutlet private var titlesStackView: UIStackView!
    @IBOutlet private var titlesStackViewHeightConstraint: NSLayoutConstraint!
    
    private let storage: CategoryStorageProtocol
    
    private let fadeDuration: TimeInterval = 1.0
    private let stackViewHeight: Int = 50
    private let stackViewSpacing: Int = 10
    private let flashCount: Float = 2
    
    init(storage: CategoryStorageProtocol) {
        self.storage = storage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleViews()
        configureHeaderView()
        setupStackViewHeightConstraint()
        setupHiddenNavigationTitle()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        setInitialState()
    }
    
    private func configureHeaderView() {
        logoView.isHidden = storage.headerIsHidden
    }
    
    private func setupStackViewHeightConstraint() {
        let categoriesCount = storage.categories.count
        let height = categoriesCount * stackViewHeight + (categoriesCount - 1) * stackViewSpacing
        
        titlesStackViewHeightConstraint.constant = CGFloat(height)
        titlesStackViewHeightConstraint.priority = .defaultHigh
    }
    
    private func setupTitleViews() {
        for category in storage.categories {
            titlesStackView.addArrangedSubview(category.view(self))
        }
    }
    
    private func setInitialState() {
        titlesStackView.arrangedSubviews.forEach { view in
            view.alpha = 1
            view.isUserInteractionEnabled = true
            
            let loadingView = view as? LoadingButtonView
            loadingView?.alpha = 1
            loadingView?.resetLoadingLabel()
            
            let configurationView = view as? MenuConfigurationView
            configurationView?.resetState()
        }
        //TODO: refactor
    }
    
    private func changeState(for view: LoadingButtonView, with viewController: UIViewController?) {
        if !storage.hasLoader {
            DispatchQueue.main.asyncAfter(deadline: .now() + fadeDuration) { [weak self] in
                guard let self = self else { return }
                self.navigateToNextPage(with: viewController)
            }
        } else {
            view.showLoading(withDuration: fadeDuration) { [weak self] in
                guard let self = self else { return }
                self.navigateToNextPage(with: viewController)
            }
        }
    }
    
    private func navigateToNextPage(with viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupHiddenNavigationTitle() {
        title = storage.title
        navigationItem.titleView = UIView()
    }
    
    private func fadeUnselectedViews(for view: UIView, till value: CGFloat, _ interactionEnabled: Bool) {
        for subview in titlesStackView.arrangedSubviews where view != subview {
            subview.isUserInteractionEnabled = interactionEnabled
            subview.fade(withDuration: fadeDuration, till: value)
        }
    }
}

extension MenuViewController: LoadingButtonViewDelegate {
    func didPressTitleButton(view: LoadingButtonView, viewController: UIViewController?) {
        changeState(for: view, with: viewController)
        fadeUnselectedViews(for: view, till: 0, false)
    }
}

extension MenuViewController: ConfigurationViewDelegate {
    func didPressValueButton(type: ConfigurationCellType) {
        switch type {
        case .lights:
            blinkBackground()
        default:
            break
        }
    }
    
    func didTapView(_ view: MenuConfigurationView, _ isActive: Bool) {
        fadeUnselectedViews(for: view, till: isActive ? 0.25 : 1, !isActive)
    }
}
