//
//  GetWords.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//


import Foundation
import RxSwift
import CleanUseCase

class GetWords: ObservableUseCase<GetWords.Input, GetWords.Output> {
    
    private var repository: WordRepositoryProtocol!
    
    convenience init(repository: WordRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: GetWords {
        return GetWords(repository: WordRepository())
    }
    
    override func createUseCase(input: GetWords.Input) -> Observable<GetWords.Output> {
        return repository.getWords(wordsIDs: input.wordsIDs).map(Output.init)
    }
    
}

extension GetWords {
    
    struct Input {
        let wordsIDs: [Int]
    }
    
    struct Output {
        let words: [Word]
    }
    
}
