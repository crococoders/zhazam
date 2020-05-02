//
//  LoadingButtonView.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol LoadingButtonViewDelegate: AnyObject {
    func didPressTitleButton(_ view: LoadingButtonView)
}

final class LoadingButtonView: UIView {
    private let title: String
    weak var delegate: LoadingButtonViewDelegate?
    
    @IBOutlet private var titleButton: UIButton!
    @IBOutlet private var loadingLabel: LoadingLabel!
    
    init(title: String) {
        self.title = title
        
        super.init(frame: .zero)
        
        loadFromNib()
        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoading(withDuration: TimeInterval, completion: @escaping() -> Void) {
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
        titleButton.setTitle(title, for: .normal)
    }
    
    @IBAction private func titleButtonPressed(_ sender: UIButton) {
        delegate?.didPressTitleButton(self)
    }
    
    private func animateTitle(completion: @escaping() -> Void) {
        loadingLabel.generateFakeLoading(completion: completion)
    }
}
