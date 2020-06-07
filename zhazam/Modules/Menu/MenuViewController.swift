//
//  MenuViewController.swift
//  zhazam
//
//  Created by Sanzhar Alim on 4/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit
import Hero
import MessageUI

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
    
    // swiftlint:disable function_body_length
    private func changeState(for view: LoadingButtonView, with type: ViewControllerType?) {
        guard let type = type else { return }
        
        var viewController: UIViewController
        
        switch type {
        case .gameModes:
            viewController = MenuViewController(storage: GameModesStorage())
        case .settings:
            viewController = MenuViewController(storage: SettingsStorage())
        case .countdown(let type):
            viewController = CountdownViewController(type: type)
        case .choice:
            viewController = ChoiceViewController(viewModel:
                TitledTextViewModel(placeholder: R.string.localizable.nickname(), buttonIsHidden: true))
        case .statistics:
            viewController = StatisticsViewController()
        case .leaderBoards:
            viewController = LeaderBoardViewController()
        }
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
    // swiftlint:enable function_body_length
    
    private func shareButtonConfiguration(view: LoadingButtonView) {
        let title = view.getButtonTitle()
        title == R.string.localizable.share() ? sendShareData() : nil
    }
    
    private func sendShareData() {
        guard let lauchScreenImage = R.image.shareScreen() else { return }
        let mainTitle = R.string.localizable.downloadApp()
        let shareAllData: [Any] = [lauchScreenImage, mainTitle]
        let activityViewController = UIActivityViewController(activityItems: shareAllData,
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func contactButtonConfiguration(view: LoadingButtonView) {
        let title = view.getButtonTitle()
        title == R.string.localizable.contacts() ? showMainComposer() : nil
    }
    
    private func showMainComposer() {
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["abai.kalikov@gmail.com"])
        composer.setSubject("Zhazam Support Message")
        composer.setMessageBody("Leave your feedbacks here.", isHTML: false)
        
        present(composer, animated: true)
    }
    
    private func navigateToNextPage(with viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        viewController.hero.isEnabled = true
        self.navigationController?.hero.isEnabled = true
        self.navigationController?.hero.navigationAnimationType = .selectBy(
            presenting: .zoom,
            dismissing: .zoomOut)
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
    func didPressTitleButton(view: LoadingButtonView, type: ViewControllerType?) {
        changeState(for: view, with: type)
        fadeUnselectedViews(for: view, till: 0, false)
        shareButtonConfiguration(view: view)
        contactButtonConfiguration(view: view)
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

extension MenuViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
