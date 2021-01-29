//
//  AddCollection.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase

class AddCollection: SingleUseCase<AddCollection.Input, Void> {
    
    private var repository: CollectionRepositoryProtocol!
    
    convenience init(repository: CollectionRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: AddCollection {
        return AddCollection(repository: CollectionRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return repository.addCollection(collection: input.collection)
    }
    
}

extension AddCollection {
    
    struct Input {
        let collection: Collection
    }
    
}
