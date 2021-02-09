//
//  RemoveWordsFromCollection.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase

class RemoveWordsFromCollection: SingleUseCase<RemoveWordsFromCollection.Input, Void> {
    
    private var repository: CollectionRepositoryProtocol!
    
    convenience init(repository: CollectionRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: RemoveWordsFromCollection {
        return RemoveWordsFromCollection(repository: CollectionRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return repository.removeWords(wordIDs: input.wordsIDs, fromCollection: input.collectionID)
    }
    
}

extension RemoveWordsFromCollection {
    
    struct Input {
        let collectionID: Int
        let wordsIDs: [Int]
    }
    
}
