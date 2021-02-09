//
//  GetCollection.swift
//  Thesis
//
//  Created by Максим Василаки on 18.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase
import CleanMapper

class GetCollection: ObservableUseCase<GetCollection.Input, GetCollection.Output> {
    
    private var repository: CollectionRepositoryProtocol!
    
    convenience init(repository: CollectionRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: GetCollection {
        return GetCollection(repository: CollectionRepository())
    }
    
    override func createUseCase(input: Input ) -> Observable<Output> {
        return repository.getCollection(collectionID: input.collectionID).map(Output.init)
    }
    
}

extension GetCollection {
    
    struct Input {
        let collectionID: Int
    }
    
    struct Output {
        let collections: Collection
    }
    
}
