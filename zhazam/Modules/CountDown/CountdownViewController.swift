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
    private var type: GameType
    
    @IBOutlet private var pickerView: UIPickerView!
    
    init(type: GameType) {
        self.type = type
        
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
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
            routeToGame()
        }
    }
    
    private func routeToGame() {
        let viewController: UIViewController
        switch type {
        case .classic:
            viewController = ClassicModeViewController()
        case .arcade:
            viewController = ArcadeModeViewController()
        case .time:
            viewController = TimeModeViewController()
        }
        navigationController?.pushViewController(viewController, animated: true)
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
