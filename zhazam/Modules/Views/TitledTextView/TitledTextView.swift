//
//  TitledTextView.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class TitledTextView: UIView {

    private var actions: [String: Callback]?
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    
    convenience init(viewModel: TitledTextViewModel) {
        self.init(frame: CGRect.zero)
        
        textField.delegate = self
        configure(viewModel: viewModel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadFromNib()
    }
    
    private func perform(action: @escaping Callback) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            action()
        }
    }
    
    private func configure(viewModel: TitledTextViewModel) {
        titleLabel.text = viewModel.title
        textField.placeholder = viewModel.placeholder
        actions = viewModel.actions
    }
}

extension TitledTextView: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if let action = actions?[updatedString ?? ""] {
            perform(action: action)
        }
        
        return true
    }
}
