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
        static let pickerViewRowHeight: CGFloat = 200
        static let reusingViewFontSize: CGFloat = 140
        static let timeInterval: TimeInterval = 1.0
    }
    
    private let count: Int = 3
    private var index = 0
    private var timer = Timer()
    
    @IBOutlet private var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePickerView()
        configureTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    private func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func configureTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: Constants.timeInterval,
                                     target: self, selector: #selector(timerDidUpdate),
                                     userInfo: nil, repeats: true)
        timer.fire()
    }
    
    private func hidePickerViewSelectionIndicator(pickerView: UIPickerView) {
        pickerView.subviews[1].isHidden = true
        pickerView.subviews[2].isHidden = true
    }
    
    @objc private func timerDidUpdate() {
        pickerView.selectRow(index, inComponent: 0, animated: true)
        index += 1
        let isCountDownEnded: Bool = count < index

        if isCountDownEnded {
            timer.invalidate()
            navigationController?.pushViewController(ClassicModeViewController(), animated: true)
        }
    }
}

extension CountdownViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        Constants.pickerViewRowHeight
    }

    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        hidePickerViewSelectionIndicator(pickerView: pickerView)

        return TimerRowView(rowData: "\(count - row)")
    }
}
