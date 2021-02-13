//
//  UIViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 13.02.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

extension UIViewController {
    
    private func getHeight(from notification: Notification) -> CGFloat {
        guard let endFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return 0.0
        }
        return endFrameValue.cgRectValue.height
    }
    
    var keyboardHeight: ControlEvent<CGFloat> {
        let openedKeyboardHeight = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).map(getHeight(from:))
        let closedKeyboardHeight = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification).map({ _ in CGFloat(0) })
        let keyboardHeight = Observable.merge([openedKeyboardHeight, closedKeyboardHeight])
        return ControlEvent(events: keyboardHeight)
    }
    
    var endEditing: Binder<Void> {
        return Binder(self.base, binding: { controller, _ in
            controller.view.endEditing(true)
        })
    }
    
}
