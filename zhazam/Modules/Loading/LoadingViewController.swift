//
//  LoadingViewController.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 8/20/19.
//  Copyright © 2019 Nurbek Ismagulov. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRandomPercents(from: Int.random(in: 1...4) * 10)
    }
    
    func generateRandomPercents(from number: Int) {
        if number < 100 {
            let randomNumber = number + Int.random(in: 0...(100-number)/10) * 10
            percentageLabel.text = randomNumber == 100 ? "\(randomNumber)." : "0\(randomNumber)."
            let time = Double.random(in: 0.5...1)
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.generateRandomPercents(from: randomNumber)
            }
        }
        //push to next vc
    }
}
