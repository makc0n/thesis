//
//  LoaderViewInteractor.swift
//  PatientDiary
//
//  Created by Artem Eremeev on 14.11.2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoaderViewInteractor: NSObject {
    
    private weak var parentView: UIView?
    
    private let loaderView = LoaderView()
    
    init(for parentView: UIView? = (UIApplication.shared.delegate as? AppDelegate)?.window) {
        self.parentView = parentView
        loaderView.alpha = 0.0
        
        if let parentView = parentView {
            loaderView.translatesAutoresizingMaskIntoConstraints = false
            parentView.addSubview(loaderView)
            parentView.addConstraints([
                parentView.leftAnchor.constraint(equalTo: loaderView.leftAnchor),
                parentView.rightAnchor.constraint(equalTo: loaderView.rightAnchor),
                parentView.topAnchor.constraint(equalTo: loaderView.topAnchor),
                parentView.bottomAnchor.constraint(equalTo: loaderView.bottomAnchor)
            ])
        }
        
    }
    
    deinit {
        loaderView.removeFromSuperview()
    }
    
    private var showAnimation: UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.1, curve: .easeIn, animations: { [unowned self] in
            self.loaderView.alpha = 1.0
        })
    }
    
    private var hideAnimation: UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.1, curve: .easeOut, animations: { [unowned self] in
            self.loaderView.alpha = 0.0
        })
    }
    
    func set(_ loading: Bool) {
        if loading {
            showAnimation.startAnimation()
        } else {
            hideAnimation.startAnimation()
        }
    }
    
}

extension Reactive where Base: LoaderViewInteractor {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base, binding: { view, isLoading in
            view.set(isLoading)
        })
    }
    
}
