//
//  AddSynonyms.swift
//  Thesis
//
//  Created by Максим Василаки on 17.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase

class AddSynonyms: SingleUseCase<AddSynonyms.Input, Void> {
    
    private var repository: WordRepositoryProtocol!
    
    convenience init(repository: WordRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: AddSynonyms {
        return AddSynonyms(repository: WordRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return repository.addSynonyms(synonymsIDs: input.synonymsIDs, for: input.wordID)
    }
    
}

extension AddSynonyms {
    
    struct Input {
        let wordID: String
        let synonymsIDs: [String]
    }
    
}
