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
    }
    
    @IBOutlet private var percentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateFakeLoading(from: Int.random(in: 1...4))
    }
    
    private func generateFakeLoading(from percentage: Int) {
        guard percentage < Constants.maxAvailablePercentage else {
            //push to next vc
            return
        }
        let randomNumber = Int.random(in: percentage...Constants.maxAvailablePercentage)
        let delayTime = Double.random(in: 0.5...1)
        setPercentageLabel(number: randomNumber)
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) { [weak self] in
            self?.generateFakeLoading(from: randomNumber)
        }
    }
    
    private func setPercentageLabel(number: Int) {
        percentageLabel.text = number < Constants.maxAvailablePercentage ? "0\(number)0." : "\(number)0."
    }
}
