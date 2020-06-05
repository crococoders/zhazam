//
//  ChoiceProvider.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol ChoiceProviderDelegate: AnyObject {
    func didSetUsername(_ username: String?)
    func didSaveName()
}

class ChoiceProvider {
    
    weak var delegate: ChoiceProviderDelegate?
    
    func saveUsername(with username: String?) {
        guard let username = username else { return }
        NetworkManager.shared.createUser(with: username) { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.delegate?.didSaveName()
            }
        }
    }
    
    func setUsername() {
        NetworkManager.shared.getUsername { [weak self] username in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.delegate?.didSetUsername(username)
            }
        }
    }
}
