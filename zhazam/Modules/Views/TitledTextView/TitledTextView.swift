//
//  TitledTextView.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class TitledTextView: UIView {
    
    var onComplete: Callback?

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    
    private var readyText: String?
    
    convenience init(title: String,
                     placeholder: String,
                     readyText: String? = nil) {
        self.init(frame: CGRect.zero)
        
        titleLabel.text = title
        textField.delegate = self
        textField.placeholder = placeholder
        self.readyText = readyText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadFromNib()
    }
    
    private func performCompletion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.onComplete?()
        }
    }
}

extension TitledTextView: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if let text = readyText, updatedString == text {
            performCompletion()
        }
        
        return true
    }
}
