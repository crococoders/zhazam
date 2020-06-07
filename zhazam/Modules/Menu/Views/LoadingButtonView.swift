//
//  LoadingButtonView.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol LoadingButtonViewDelegate: MenuSubviewsDelegate {
    func didPressTitleButton(view: LoadingButtonView, type: ViewControllerType?)
}

final class LoadingButtonView: UIView {
    private let category: CategoryViewModel
    weak var delegate: LoadingButtonViewDelegate?
    
    @IBOutlet private var titleButton: UIButton!
    @IBOutlet private var loadingLabel: LoadingLabel!
    
    init(_ category: CategoryViewModel) {
        self.category = category
        
        super.init(frame: .zero)
        
        loadFromNib()
        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading(withDuration: TimeInterval, completion: @escaping Callback) {
        UIView.animate(withDuration: withDuration, delay: 0, options: [.curveLinear], animations: {
            self.loadingLabel.alpha = 1
        }, completion: { _ in
            self.animateTitle(completion: completion)
        })
    }
    
    func resetLoadingLabel() {
        loadingLabel.alpha = 0
        loadingLabel.text = ""
    }
    
    private func setupTitle() {
        titleButton.setTitle(category.title, for: .normal)
    }
    
    func getButtonTitle() -> String {
        let title = titleButton.titleLabel?.text
        return title ?? ""
    }
    
    @IBAction private func titleButtonPressed(_ sender: UIButton) {
        delegate?.didPressTitleButton(view: self, type: category.type)
    }
    
    private func animateTitle(completion: @escaping Callback) {
        loadingLabel.generateFakeLoading(completion: completion)
    }
}
