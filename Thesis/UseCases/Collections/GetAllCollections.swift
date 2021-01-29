//
//  GetCollections.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase

class GetAllCollections: ObservableUseCase< Void, GetAllCollections.Output> {
    
    private var repository: CollectionRepositoryProtocol!
    
    convenience init(repository: CollectionRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: GetAllCollections {
        return GetAllCollections(repository: CollectionRepository())
    }
    
    override func createUseCase(input: Void) -> Observable<Output> {
        return repository.getCollections().map(Output.init)
    }
    
}

extension GetAllCollections {
    
    struct Output {
        let collections: [Collection]
    }
    
}
