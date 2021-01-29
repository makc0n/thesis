//
//  AddWordsToCollection.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase

class AddWordsToCollection: SingleUseCase<AddWordsToCollection.Input, Void> {
    
    private var repository: CollectionRepositoryProtocol!
    
    convenience init(repository: CollectionRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: AddWordsToCollection {
        return AddWordsToCollection(repository: CollectionRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return repository.addWords(wordIDs: input.wordsIDs, toCollection: input.collectionID)
    }
    
}

extension AddWordsToCollection {
    
    struct Input {
        let collectionID: String
        let wordsIDs: [String]
    }
    
}
