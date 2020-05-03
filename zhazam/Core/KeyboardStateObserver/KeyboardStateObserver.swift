//
//  KeyboardStateObserver.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

typealias KeyboardStateEventClosure = (_ rect: CGRect, _ animationTime: TimeInterval, _ animationCurve: UInt) -> Void

protocol KeyboardStateObservering {
    func startListening()
    func stopListening()
    
    var willShow: KeyboardStateEventClosure? { get set }
    var willHide: KeyboardStateEventClosure? { get set }
}

struct KeyboardNotificationInfo {
    var rect: CGRect
    var time: Double
    var curve: UInt
}

class KeyboardStateObserver: KeyboardStateObservering {
    
    var willShow: KeyboardStateEventClosure?
    var willHide: KeyboardStateEventClosure?
    private var observers: [Any]?
    
    func startListening() {
        let willShowObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil) { (note) in
                guard let info = self.getNotificationInfo(note: note) else { return }
                self.willShow?(info.rect, info.time, info.curve)
        }
        let willHideObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil) { (note) in
                guard let info = self.getNotificationInfo(note: note) else { return }
                self.willHide?(info.rect, info.time, info.curve)
        }
        
        observers = ([willShowObserver, willHideObserver])
    }
    
    func stopListening() {
        observers?.forEach { NotificationCenter.default.removeObserver($0) }
    }
    
    deinit {
        observers?.forEach { NotificationCenter.default.removeObserver($0) }
    }
    
    private func getNotificationInfo(note: Notification) -> KeyboardNotificationInfo? {
        guard let info = note.userInfo,
            let rect = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let time = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
            else {
                return nil
        }
        
        return KeyboardNotificationInfo(rect: rect, time: time, curve: curve)
    }
}
