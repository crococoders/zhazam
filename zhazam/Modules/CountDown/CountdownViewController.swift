//
//  StartGameTimerViewController.swift
//  zhazam
//
//  Created by Abai Kalikov on 4/22/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class CountdownViewController: UIViewController {
    
    private enum Constants {
        static let timerCount = 3
        static let pickerViewRowHeight: CGFloat = 200
        static let reusingViewFontSize: CGFloat = 140
        static let timerTimeInterval: TimeInterval = 1.0
    }
    
    @IBOutlet private var pickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePickerView()
    }
    
    private func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureCountdownTimer {
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
    }
    
    private func configureCountdownTimer(completion: @escaping() -> Void) {
        var rowIndex = 0
        Timer.scheduledTimer(withTimeInterval: Constants.timerTimeInterval, repeats: true) { timer in
            self.pickerView.selectRow(rowIndex, inComponent: 0, animated: true)
            rowIndex += 1
            let isCountDownEnded: Bool = Constants.timerCount < rowIndex
            
            if isCountDownEnded {
                timer.invalidate()
                completion()
            }
        }
    }
    
    private func hidePickerViewSelectionIndicator(pickerView: UIPickerView) {
        pickerView.subviews[1].isHidden = true
        pickerView.subviews[2].isHidden = true
    }
    
    private func labelCreations(row: Int) -> UILabel {
        let label = UILabel()
        label.textColor = R.color.textColor()
        label.textAlignment = .center
        label.font = R.font.helveticaNeueBold(size: Constants.reusingViewFontSize)
        label.text = "\(Constants.timerCount - row)"
        return label
    }
}

extension CountdownViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.timerCount
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Constants.pickerViewRowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        hidePickerViewSelectionIndicator(pickerView: pickerView)
        
        return labelCreations(row: row)
    }
}
