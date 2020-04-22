//
//  StartGameTimerViewController.swift
//  zhazam
//
//  Created by Abai Kalikov on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class StartGameTimerViewController: UIViewController {
    
    private enum Constants {
        static let counterArray: [String] = ["3", "2", "1", ""]
        static let lastRowDisplayIndex = 1
        static let pickerViewRowHeight: CGFloat = 200
        static let reusingViewFontSize: CGFloat = 140
        static let timerTimeInterval: TimeInterval = 1.0
    }
    
    @IBOutlet weak var timerPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
    }
    
    private func configurePickerView() {
        timerPickerView.dataSource = self
        timerPickerView.delegate = self
        timerPickerView.isUserInteractionEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        makeTimer { [weak self] in
            guard let self = self else { return }
            self.performAnimatedTransition()
        }
    }
    
    private func performAnimatedTransition() {
//                guard let window = UIApplication.shared.keyWindow else { return }
//                window.rootViewController = UINavigationController(rootViewController: LoadingViewController())
//                UIView.transition(with: window,
//                                  duration: 0.7,
//                                  options: .transitionFlipFromBottom,
//                                  animations: {},
//                                  completion: nil)
        
        //make transition to Game page
    }
    
    private func makeTimer(completion: @escaping() -> Void) {
        var rowIndex = 0
        Timer.scheduledTimer(withTimeInterval: Constants.timerTimeInterval, repeats: true) { timer in
            self.timerPickerView.selectRow(rowIndex, inComponent: 0, animated: true)
            rowIndex += 1
            
            if Constants.counterArray.count <= rowIndex - Constants.lastRowDisplayIndex {
                timer.invalidate()
                completion()
            }
        }
    }
    
    private func hidePickerViewSelectionIndicator(pickerView: UIPickerView) {
        pickerView.subviews[1].isHidden = true
        pickerView.subviews[2].isHidden = true
    }
}

extension StartGameTimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.counterArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Constants.pickerViewRowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        //hide selection indicator
        hidePickerViewSelectionIndicator(pickerView: pickerView)
        
        //create custom label
        var label = UILabel()
        if let view = view as? UILabel { label = view }
        label.textColor = R.color.textColor()
        label.textAlignment = .center
        label.font = R.font.helveticaNeueBold(size: Constants.reusingViewFontSize)
        label.text = Constants.counterArray[row]
        return label
    }
}
