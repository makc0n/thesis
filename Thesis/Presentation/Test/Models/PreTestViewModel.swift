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
    
    let usedWordsIDs: [Int]
    let testConfiguration: Test
    
    let getUser = GetUser.default.use()
    lazy var getWords = GetWords.default.use(input: GetWords.Input(wordsIDs: self.usedWordsIDs))
    
    let currentWord = BehaviorRelay<Word?>(value: nil)
    
    let nextWord = PublishSubject<Void>()
    let acceptWord = PublishSubject<Void>()
    let willAppear = PublishSubject<Void>()
    
    lazy var wordEng = currentWord.unwrap().map({$0.translate})
    lazy var wordRus = currentWord.unwrap().map({$0.word})
    lazy var wordTrascription = currentWord.unwrap().map({$0.transcription})
    
    init(testConfiguration: Test ) {
        self.usedWordsIDs = testConfiguration.usedWordsIDs
        self.testConfiguration = testConfiguration
    }
    
    override func subscribe() {

        let base = Observable.combineLatest(getUser.map({$0.user}), getWords.map({$0.words}))
        
        base.map(generateRandomWord).take(1).bind(to: currentWord).disposed(by: disposeBag)
        
        nextWord.withLatestFrom(base)
            .map(generateRandomWord)
            .bind(to: currentWord)
            .disposed(by: disposeBag)
        
        
        acceptWord.bind(onNext: acceptWordAction).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func generateRandomWord(user: User, words: [Word]) -> Word? {
        return PreTestAdapter.smartRandomWord(fromWords: words, forUser: user)
    }
    
    private func acceptWordAction() {
        
        guard let word = currentWord.value else {
            return
        }
        
        self.testConfiguration.appendWord(word)
        nextWord.onNext(())
        
    }
    
    
}
