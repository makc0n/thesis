//
//  RemoveWord.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase

class RemoveWord: SingleUseCase<RemoveWord.Input, Void> {
    
    private var repository: WordRepositoryProtocol!
    
    convenience init(repository: WordRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: RemoveWord {
        return RemoveWord(repository: WordRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return repository.removeWord(wordID: input.wordID)
    }
    
}

extension RemoveWord {
    
    struct Input {
        let wordID: String
    }
    
}
