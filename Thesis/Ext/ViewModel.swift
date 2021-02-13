//
//  ViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 13.02.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM

extension ViewModel {
    
    func loadingStarted() {
        isLoading.onNext(true)
    }
    func loadingEnded() {
        isLoading.onNext(false)
    }
}
