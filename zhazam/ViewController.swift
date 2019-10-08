//
//  ViewController.swift
//  zhazam
//
//  Created by Beknar Danabek on 8/20/19.
//  Copyright © 2019 Beknar Danabek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.font = UIFont(.bold, withSize: 20)
    }

}
