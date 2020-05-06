//
//  ExtendedConfigurationView.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol ConfigurationViewDelegate: MenuSubviewsDelegate {
    func didPressValueButton()
    func didTapView(_ view: ExtendedConfigurationView, _ isActive: Bool)
}

class ExtendedConfigurationView: UIView {
    
    weak var delegate: ConfigurationViewDelegate?
    
    private let category: CategoryViewModel
    
    private var isActive = false {
        didSet {
            changeViewState()
        }
    }
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var valueButton: UIButton!
    
    init(_ category: CategoryViewModel) {
        self.category = category
        
        super.init(frame: .zero)
        
        loadFromNib()
        setupInitialState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func changeViewState() {
        valueButton.isUserInteractionEnabled = self.isActive
        
        fadeButton()
    }
    
    private func setupInitialState() {
        titleLabel.text = category.title
        
        valueButton.alpha = 0
        valueButton.isUserInteractionEnabled = false
    }
    
    private func fadeButton() {
        valueButton.alpha = isActive ? 0 : 1
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear], animations: {
            self.valueButton.alpha = self.isActive ? 1 : 0
        }, completion: nil)
    }
    
    @IBAction private func valueButtonPressed(_ sender: UIButton) {
        delegate?.didPressValueButton()
    }
    
    @IBAction private func didTapView(_ sender: UITapGestureRecognizer) {
        isActive = !isActive
        
        delegate?.didTapView(self, isActive)
    }
}
