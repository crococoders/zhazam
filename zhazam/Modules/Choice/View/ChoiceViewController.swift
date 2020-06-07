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
    private let provider = ChoiceProvider()
    
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
        configureProvider()
        setupBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        textField.resignResponder()
    }
    
    private func setupLocalization() {
        backButton.setTitle("Continue".localized.lowercased(), for: .normal)
        backButton.isHidden = viewModel.buttonIsHidden
    }
    
    private func configureTextField() {
        textField.delegate = self
    }
    
    private func configure(viewModel: TitledTextViewModel) {
        titleLabel.text = viewModel.title
        textField.placeholder = viewModel.placeholder
    }
    
    private func configureProvider() {
        provider.delegate = self
        provider.setUsername()
    }
    
    private func perform(action: @escaping Callback) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: false, completion: action)
        }
    }
    
    private func setupBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save".localized.lowercased(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveTapped))
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: false, completion: viewModel.onDismiss)
    }
    
    @objc private func saveTapped() {
        provider.saveUsername(with: textField.text)
    }
}

extension ChoiceViewController: ChoiceProviderDelegate {
    func didSetUsername(_ username: String?) {
        textField.text = username
    }
    
    func didSaveName() {
        navigationController?.popViewController(animated: true)
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
