//
//  ChoiceTestViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 28.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift
import RxCocoa
import RxDataSources

class ChoiceTestViewModel: ViewModel{
    
    var words: [Word]
    let testConfiguration: Test
    var currentAttempt = 0
    
    let getAllWords = GetAllWords.default.use()
    
    let uncorrectAnswer = PublishSubject<Void>()
    let correctAnswer = PublishSubject<Void>()
    let cellSelected = PublishSubject<ChoiceItemModel>()
    
    let currentWord = BehaviorRelay<Word?>(value: nil)
    
    lazy var models = BehaviorRelay<[ChoiceItemModel]>(value: [])
    lazy var sections = models.map({ [SectionModel<String,ChoiceItemModel>(model: "", items: $0.shuffled())]})
    
    
    init(testConfiguration: Test) {
        self.words = testConfiguration.words
        self.testConfiguration = testConfiguration
    }
    
    override func subscribe() {
        
        self.currentWord.accept(words.removeFirst())
        self.cellSelected.bind(onNext: modelSelectedAction(cellModel:)).disposed(by: disposeBag)
        
        Observable.combineLatest(currentWord.unwrap(), getAllWords).map({ word, allWords -> [ChoiceItemModel] in
            let synonyms = allWords.words.filter({word.synonymsID.contains($0.id) })
            var result: [Word] = [word]
            
            if !synonyms.isEmpty {
                result.append(synonyms.randomElement()!)
            }
            while result.count != 4 {
                result.append(allWords.words.randomElement()!)
            }
            
            return result.map({ ChoiceItemModel($0)})
        }).bind(to: models).disposed(by: disposeBag)
        
        correctAnswer.bind(onNext: correctAnswerAction).disposed(by: disposeBag)
        uncorrectAnswer.bind(onNext: uncorrectAnswerAction).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func modelSelectedAction( cellModel: ChoiceItemModel) {
        
        guard let currentWord = self.currentWord.value else {
            return
        }
        let attempt: AttemptType = currentAttempt == 0 ? .firstAttempt : .correctionAttempt(attempt: currentAttempt)
        let answerResult = testConfiguration.verifyAnswer(wordID: currentWord.id, answer: cellModel.word.translate, attempt: attempt)
        
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
        self.currentAttempt = 0
        
    }
    
    private func uncorrectAnswerAction() {
        if currentAttempt >= self.testConfiguration.currentQuest.attemptCount {
            if self.words.isEmpty {
                self.testConfiguration.nextQuest()
                return
            }
            self.currentWord.accept(self.words.removeFirst())
            self.currentAttempt = 0
        }
        
    }
}
