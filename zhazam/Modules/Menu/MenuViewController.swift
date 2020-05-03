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
    
    private let categories = CategoryViewModelStorage().viewModels
    
    private enum Constants {
        static let fadeDuration: TimeInterval = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showHiddenViews()
    }
    
    private func setupTitleViews() {
        for title in categories {
            let buttonView = LoadingButtonView(title: title)
            buttonView.delegate = self
            
            titlesStackView.addArrangedSubview(buttonView)
        }
    }
    
    private func fade(view: UIView) {
        UIView.animate(withDuration: Constants.fadeDuration, delay: 0, options: [.curveLinear], animations: {
            view.alpha = 0
        }, completion: nil)
    }
    
    private func showHiddenViews() {
        titlesStackView.arrangedSubviews.forEach { view in
            let loadingView = view as? LoadingButtonView
            loadingView?.alpha = 1
            
            loadingView?.resetLoadingLabel()
        }
    }
    
    private func changeState(for view: LoadingButtonView) {
        view.showLoading(withDuration: Constants.fadeDuration) { [weak self] in
            guard let self = self else { return }
            //TODO: Push new view controller
            let vc = ClassicModeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MenuViewController: LoadingButtonViewDelegate {
    func didPressTitleButton(_ view: LoadingButtonView) {
        changeState(for: view)
        
        for subview in titlesStackView.arrangedSubviews where view != subview {
            fade(view: subview)
        }
    }
}
