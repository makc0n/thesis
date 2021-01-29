//
//  GetAllWords.swift
//  Thesis
//
//  Created by Максим Василаки on 18.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase

class GetAllWords: ObservableUseCase<Void, GetAllWords.Output> {
    
    private var repository: WordRepositoryProtocol!
    
    convenience init(repository: WordRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: GetAllWords {
        return GetAllWords(repository: WordRepository())
    }
    
    override func createUseCase(input: Void) -> Observable<Output> {
        return repository.getAllWords().map(Output.init)
    }
    
}

extension GetAllWords {
    
    struct Output {
        let words: [Word]
    }
    
}
