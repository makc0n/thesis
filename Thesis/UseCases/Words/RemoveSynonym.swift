//
//  RemoveSynonym.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase

class RemoveSynonym: SingleUseCase<RemoveSynonym.Input, Void> {
    
    private var repository: WordRepositoryProtocol!
    
    convenience init(repository: WordRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: RemoveSynonym {
        return RemoveSynonym(repository: WordRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return repository.removeSynonym(synonymID: input.synonymID, wordID: input.wordID)
    }
    
}

extension RemoveSynonym {
    
    struct Input {
        let wordID: String
        let synonymID: String
    }
    
}
