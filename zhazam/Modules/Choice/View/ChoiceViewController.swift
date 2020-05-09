//
//  ChoiceViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class ChoiceViewController: UIViewController {

    private var viewModel: TitledTextViewModel
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textField: PrimaryTextField!
    @IBOutlet private var backButton: UIButton!
    
    init(viewModel: TitledTextViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocalization()
        configureTextField()
        hideKeyboardWhenTappedAround()
        configure(viewModel: viewModel)
    }
    
    private func setupLocalization() {
        backButton.setTitle(R.string.localizable.continue(), for: .normal)
    }
    
    private func configureTextField() {
        textField.delegate = self
        textField.becomeResponder()
    }
    
    private func configure(viewModel: TitledTextViewModel) {
        titleLabel.text = viewModel.title
        textField.placeholder = viewModel.placeholder
    }
    
    private func perform(action: @escaping Callback) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.textField.resignResponder()
            self.dismiss(animated: false, completion: action)
        }
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: false, completion: viewModel.onDismiss)
    }
}

extension ChoiceViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if let action = viewModel.actions[updatedString ?? ""] {
            perform(action: action)
        }
        
        return true
    }
}
