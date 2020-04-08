//
//  LoadingViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 8/20/19.
//  Copyright © 2019 Nurbek Ismagulov. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    @IBOutlet weak private var percentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateFakeLoading(from: Int.random(in: 1...4) * 10)
    }
    
    private func generateFakeLoading(from number: Int) {
        if number < 100 {
            let randomNumber = number + Int.random(in: 0...10-number/10)*10
            setPercentage(number: randomNumber)
            let delayTime = Double.random(in: 0.5...1)
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                self.generateFakeLoading(from: randomNumber)
            }
        }
        //push to next vc
    }
    
    private func setPercentage(number: Int) {
        percentageLabel.text = number < 100 ? "0\(number)." : "\(number)."
    }
}
