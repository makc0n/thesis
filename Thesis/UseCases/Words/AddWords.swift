//
//  AddWords.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//


import Foundation
import RxSwift
import CleanUseCase

class AddWords: SingleUseCase<AddWords.Input, AddWords.Output> {
    
    private var repository: WordRepositoryProtocol!
    
    convenience init(repository: WordRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: AddWords {
        return AddWords(repository: WordRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Output> {
        return repository.addWords(words: input.words).map(Output.init)
    }
    
}

extension AddWords {
    
    struct Input {
        let words: [Word]
    }
    
    struct Output {
        let wordsIDs: [String]
    }
    
}
