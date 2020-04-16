//
//  LoadingViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 8/20/19.
//  Copyright © 2019 Nurbek Ismagulov. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {
    private enum Constants {
        static let maxAvailablePercentage: Int = 10
        static let minDelayTime: Double = 0.5
        static let maxDelayTime: Double = 0.7
    }
    
    @IBOutlet private var percentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateFakeLoading(from: generateRandomNumber(from: 0, to: 2))
    }
    
    private func generateFakeLoading(from percentage: Int) {
        guard percentage < Constants.maxAvailablePercentage else {
            //push to next vc
            return
        }
        let randomNumber = generateRandomNumber(from: percentage,
                                                to: Constants.maxAvailablePercentage)
        setPercentageLabel(number: randomNumber)
        
        let delayTime = generateRandomDelay()
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) { [weak self] in
            self?.generateFakeLoading(from: randomNumber)
        }
    }
    
    private func generateRandomNumber(from lower: Int, to upper: Int) -> Int {
        return Int.random(in: lower...upper)
    }
    
    private func generateRandomDelay() -> Double {
        return Double.random(in: Constants.minDelayTime...Constants.maxDelayTime)
    }
    
    private func setPercentageLabel(number: Int) {
        percentageLabel.text = number < Constants.maxAvailablePercentage ? "0\(number)0." : "\(number)0."
    }
}
