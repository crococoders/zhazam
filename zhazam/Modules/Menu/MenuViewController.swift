//
//  MenuViewController.swift
//  zhazam
//
//  Created by Sanzhar Alim on 4/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {
    
    @IBOutlet private var logoView: LogoView!
    @IBOutlet private var titleButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openViewController(_ sender: UIButton) {
        fadeButtons(with: sender) { _ in
            //Perform navigation
        }
    }
    
    private func fadeButtons(with selectedButton: UIButton, completion: ((Bool) -> Void)?) {
        for button in titleButtons where selectedButton.tag != button.tag {
            UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear], animations: {
                button.alpha = 0
            }, completion: completion)
        }
    }
}
