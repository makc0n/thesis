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
    let testConfiguration: TestConfiguration
    var currentAttempt = 0
    
    let getWords = GetWords.default
    
    let answerText = PublishSubject<String>()
    let uncorrectAnswer = PublishSubject<Void>()
    let correctAnswer = PublishSubject<Void>()
    
    let currentWord = BehaviorRelay<Word?>(value: nil)
    lazy var synonymsID = currentWord.map({ $0?.synonymsID})
    lazy var synonyms = BehaviorRelay<[Word]>(value: [])
    
    init(words: [Word], testConfiguration: TestConfiguration) {
        self.words = words
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
        
        switch answer.trimmingCharacters(in: .whitespaces).lowercased() {
        case let answer where answer == currentWord.eng:
            testConfiguration.currentQuest.sendAnswer(wordID: currentWord.id, answerType: .correct)
            self.correctAnswer.onNext(())
        case let answer where synonyms.value.map({ $0.eng }).contains(answer):
            testConfiguration.currentQuest.sendAnswer(wordID: currentWord.id, answerType: .synonym)
            self.correctAnswer.onNext(())
        default:
            testConfiguration.currentQuest.sendAnswer(wordID: currentWord.id, answerType: .uncorrect)
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
        if currentAttempt >= self.testConfiguration.attempCount {
            if self.words.isEmpty {
                self.testConfiguration.nextQuest()
                return
            }
            self.currentWord.accept(self.words.removeFirst())
        }
        
    }
    
}
