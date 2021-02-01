//
//  PreTestViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 28.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift
import RxCocoa

class PreTestViewModel: ViewModel{
    
    let usedWordsIDs: [String]
    unowned let testConfiguration: Test
    
    let getUser = GetUser.default.use().share()
    lazy var getWords = GetWords.default.use(input: GetWords.Input(wordsIDs: usedWordsIDs)).share()
    
    let currentWord = BehaviorRelay<Word?>(value: nil)
    
    let nextWord = PublishSubject<Void>()
    let acceptWord = PublishSubject<Void>()
    
    lazy var wordEng = currentWord.unwrap().map({$0.eng})
    lazy var wordRus = currentWord.unwrap().map({$0.rus})
    lazy var wordTrascription = currentWord.unwrap().map({$0.transcription})
    
    init(usedWordsIDs: [String], testConfiguration: Test ) {
        self.usedWordsIDs = usedWordsIDs
        self.testConfiguration = testConfiguration
    }
    
    override func subscribe() {
        
        nextWord.withLatestFrom(Observable.combineLatest(getUser, getWords))
            .map({PreTestAdapter.smartRandomWord(fromWords: $0.1.words, forUser: $0.0.user, ignoreWordIDs: self.testConfiguration.words.map({$0.id})) })
            .bind(to: currentWord)
            .disposed(by: disposeBag)
                
        acceptWord.bind(onNext: acceptWordAction).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func acceptWordAction() {
        guard let word = currentWord.value else {
            return
        }
        
        self.testConfiguration.appendWord(word)
        
        nextWord.onNext(())
    }
    
    
}
