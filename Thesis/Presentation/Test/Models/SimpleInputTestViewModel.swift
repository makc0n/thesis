//
//  TestViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift
import RxCocoa
class SimpleInputTestViewModel: ViewModel{
    
    var words: [Word]
    let testConfiguration: Test
    var currentAttempt = 0
    
    let getWords = GetWords.default
    
    let answerText = PublishSubject<String>()
    let uncorrectAnswer = PublishSubject<Void>()
    let correctAnswer = PublishSubject<Void>()
    
    let currentWord = BehaviorRelay<Word?>(value: nil)
    lazy var synonymsID = currentWord.map({ $0?.synonymsID})
    lazy var synonyms = BehaviorRelay<[Word]>(value: [])
    
    init(testConfiguration: Test) {
        self.words = testConfiguration.words
        self.testConfiguration = testConfiguration
    }
    
    override func subscribe() {
        super.subscribe()
        
        synonymsID.unwrap().flatMap({ ids -> Observable<[Word]> in
            return GetWords.default.use(input: .init(wordsIDs: ids)).map({$0.words})
        }).bind(to: synonyms).disposed(by: disposeBag)
        
        answerText.bind(onNext: answerAction).disposed(by: disposeBag)
        correctAnswer.bind(onNext: correctAnswerAction).disposed(by: disposeBag)
        uncorrectAnswer.bind(onNext: uncorrectAnswerAction).disposed(by: disposeBag)
        
    }
    
    private func answerAction( answer: String ) {
        
        guard let currentWord = self.currentWord.value else {
            return
        }
        
        let attemptType: AttemptType = self.currentAttempt == 0 ? .firstAttempt : .correctionAttempt(attempt: self.currentAttempt)
        
        let answerResult = testConfiguration.verifyAnswer(wordID: currentWord.id, answer: answer, attempt: attemptType)
        
        switch answerResult {
        case .correct:
            self.correctAnswer.onNext(())
        case .synonym:
            self.correctAnswer.onNext(())
        case .uncorrect:
            self.uncorrectAnswer.onNext(())
        }
        
        currentAttempt += 1
    }
    
    private func correctAnswerAction() {
        if self.words.isEmpty {
            self.testConfiguration.nextQuest()
            return
        }
        self.currentWord.accept(self.words.removeFirst())
        
    }
    
    private func uncorrectAnswerAction() {
        if currentAttempt >= self.testConfiguration.currentQuest.attemptCount {
            if self.words.isEmpty {
                self.testConfiguration.nextQuest()
                return
            }
            self.currentWord.accept(self.words.removeFirst())
        }
        
    }
    
}
