//
//  ClassicModeViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ClassicModeViewController: UIViewController {
    
    private var keyboardObserver: KeyboardStateObservering = KeyboardStateObserver()

    @IBOutlet private var textView: UITextView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var textFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField()
        configureKeyboardObserving()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardObserver.startListening()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        keyboardObserver.stopListening()
    }
    
    private func configureTextField() {
        textField.becomeResponder()
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func configureKeyboardObserving() {
        keyboardObserver.willShow = { [weak self] rect, _, curve in
            self?.updateTextFieldConstraints(offset: rect.height - 12, curve: curve)
        }
        
        keyboardObserver.willHide = { [weak self] _, _, curve in
            self?.updateTextFieldConstraints(offset: 12, curve: curve)
        }
    }
    
    private func updateTextFieldConstraints(offset: CGFloat, curve: UInt) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: UIView.AnimationOptions(rawValue: curve),
            animations: { [weak self] in
                self?.textFieldBottomConstraint.constant = offset
                self?.view.layoutIfNeeded()
        })
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let count: Int = textField.text?.count ?? 0
        
        let rect = textView.layoutManager.boundingRect(forGlyphRange: NSRange(location: count,
                                                                              length: 0),
                                                                              in: textView.textContainer)
        UIView.animate(withDuration: 0.5) {
            self.textView.contentOffset = CGPoint(x: 0, y: rect.origin.y + 6.0)
        }
    }
    
    private func scroll(to location: Int) {
        let range = NSRange(location: location, length: 0)
        let rect = textView.layoutManager.boundingRect(forGlyphRange: range, in: textView.textContainer)
        
        UIView.animate(withDuration: 0.5) {
            self.textView.contentOffset = CGPoint(x: 0, y: rect.origin.y + 6.0)
        }
    }
}

extension ClassicModeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        scroll(to: updatedString?.count ?? 0)
        
        return true
    }
}
