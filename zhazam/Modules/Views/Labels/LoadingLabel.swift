//
//  LoadingLabel.swift
//  zhazam
//
//  Created by Sanzhar Alim on 5/2/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class LoadingLabel: UILabel {
    private enum Constants {
        static let timerDelay: TimeInterval = 0.08
        static let minGrow: Int = 1
        static let maxGrow: Int = 10
        static let maxSupportedValue: Int = 100
        static let completionDelay = 0.1
    }
    
    func generateFakeLoading(completion: @escaping Callback) {
        var number = 0
        
        Timer.scheduledTimer(withTimeInterval: Constants.timerDelay, repeats: true) { timer in
            self.text = number.formattedPercentage()
            number += self.generateBetween(Constants.minGrow, Constants.maxGrow)
            
            if number >= Constants.maxSupportedValue {
                self.text = "\(Constants.maxSupportedValue)."
                
                timer.invalidate()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.completionDelay) {
                    completion()
                }
            }
        }
    }
    
    func generateBetween(_ lower: Int, _ upper: Int) -> Int {
        return Int.random(in: lower...upper)
    }
}
