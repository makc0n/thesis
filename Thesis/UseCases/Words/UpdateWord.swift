//
//  UpdateWord.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//
import Foundation
import RxSwift
import CleanUseCase

class UpdateWord: SingleUseCase<UpdateWord.Input, Void> {
    
    private var repository: WordRepositoryProtocol!
    
    convenience init(repository: WordRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: UpdateWord {
        return UpdateWord(repository: WordRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return repository.updateWord(rus: input.rus, eng: input.eng, transcription: input.transcription, wordID: input.wordID)
    }
    
}

extension UpdateWord {
    
    struct Input {
        let rus: String?
        let eng: String?
        let transcription: String?
        let wordID: String
    }
    
}
