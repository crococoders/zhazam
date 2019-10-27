//
//  OnboardingViewController.swift
//  zhazam
//
//  Created by Beknar Danabek on 8/20/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    var randomNumber = Int.random(in: 1...10) * 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRandomPercents()
    }
    
    func generateRandomPercents() {
        if randomNumber < 100 {
            randomNumber = Int.random(in: randomNumber/10...10) * 10
            percentageLabel.text = randomNumber == 100 ? "\(randomNumber)." : "0\(randomNumber)."
            let time = Double.random(in: 0.5...1)
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.generateRandomPercents()
            }
        } else {
            // push to vc
        }
    }
}
