//
//  String+Extension.swift
//  zhazam
//
//  Created by Sanzhar Alim on 6/6/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        guard let path = Bundle.main.path(forResource: UserDefaultsStorage.language, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
                return self
        }

        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
