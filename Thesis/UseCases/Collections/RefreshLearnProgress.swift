//
//  RefreshLearnProgress.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import RxSwift
import CleanUseCase

class RefreshLearnProgress: SingleUseCase<Void, Void> {
    
    private var repository: CollectionRepositoryProtocol!
    
    convenience init(repository: CollectionRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: RefreshLearnProgress {
        return RefreshLearnProgress(repository: CollectionRepository())
    }
    
    override func createUseCase(input: Void) -> Single<Void> {
        return repository.refreshLearnProgress()
    }
    
}


