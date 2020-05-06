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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
            
            let loadingView = view as? LoadingButtonView
            loadingView?.alpha = 1
            
            loadingView?.resetLoadingLabel()
        }
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
}

extension MenuViewController: LoadingButtonViewDelegate {
    func didPressTitleButton(view: LoadingButtonView, viewController: UIViewController?) {
        changeState(for: view, with: viewController)
        
        for subview in titlesStackView.arrangedSubviews where view != subview {
            subview.fade(withDuration: fadeDuration, till: 0)
        }
    }
}

extension MenuViewController: ConfigurationViewDelegate {
    func didPressValueButton() {
        //
    }
    
    func didTapView(_ view: ExtendedConfigurationView, _ isActive: Bool) {
        for subview in titlesStackView.arrangedSubviews where view != subview {
            subview.isUserInteractionEnabled = !isActive
            subview.fade(withDuration: fadeDuration, till: isActive ? 0.25 : 1)
        }
    }
}
