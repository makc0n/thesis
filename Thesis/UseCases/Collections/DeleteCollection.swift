//
//  DeleteCollection.swift
//  Thesis
//
//  Created by Максим Василаки on 27.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase
import CleanMapper

class DeleteCollection: SingleUseCase<DeleteCollection.Input, Void> {
    
    private var repository: CollectionRepositoryProtocol!
    
    convenience init(repository: CollectionRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: DeleteCollection {
        return DeleteCollection(repository: CollectionRepository())
    }
    
    override func createUseCase(input: Input ) -> Single<Void> {
        return repository.deleteCollection(collectionID: input.collectionID)
    }
    
}

extension DeleteCollection {
    
    struct Input {
        let collectionID: Int
    }
    
    
}
