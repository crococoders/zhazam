//
//  ResultProvider.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/10/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

protocol ResultProviderDelegate: AnyObject {
    func didSetResult(_ result: GameResult?)
}

class ResultProvider {
    
    weak var delegate: ResultProviderDelegate?
    
    func save(score: Int, with type: GameType) {
        NetworkManager.shared.sendGameResult(with: score, type: type) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.delegate?.didSetResult(result)
            }
        }
    }
}
