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
        logoView.animate()
    }
}
