//
//  TokenGenerator.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct TokenGenerator {
    static let shared = TokenGenerator()
    
    let keychain = KeychainAccess()
    let key = Bundle.main.bundleIdentifier ?? ""
    
    func getToken() -> String? {
        let uniqueID = keychain.createUniqueID()
        
        if hasValueFor(key: key), let token = keychain.load(key: key) {
            return token
        }
        
        guard let data = uniqueID.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        if keychain.save(key: key, data: data) == 0, let token = keychain.load(key: key) {
            return token
        }
        
        return nil
    }
    
    // MARK: Do NOT call this method. For test needs only.
    func deleteToken() {
        keychain.deleteKeychainData(itemKey: key)
    }
    
    private func hasValueFor(key: String) -> Bool {
        if keychain.load(key: key) != nil {
            return true
        }
        
        return false
    }
}
