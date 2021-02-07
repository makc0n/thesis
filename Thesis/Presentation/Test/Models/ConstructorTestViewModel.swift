//
//  ConstructorTestViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 29.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift
import RxCocoa
import RxDataSources

class ConstructorTestViewModel: ViewModel{
    
    var words: [Word]
    unowned let testConfiguration: Test
    var currentAttempt = 0
    
    let uncorrectAnswer = PublishSubject<Void>()
    let correctAnswer = PublishSubject<Void>()
    let cellSelected = PublishSubject<ConstructorItemModel>()
    
    let currentWord = BehaviorRelay<Word?>(value: nil)
    
    lazy var models = BehaviorRelay<[ConstructorItemModel]>(value: [])
    lazy var sections = models.map({ [SectionModel<String,ConstructorItemModel>(model: "", items: $0)]})
    
    lazy var answer = BehaviorRelay<String>(value: "")
    
    init(testConfiguration: Test) {
        self.words = testConfiguration.words
        self.testConfiguration = testConfiguration
    }
    
    override func subscribe() {
        
        currentWord.unwrap().map({ $0.eng.shuffled().map(ConstructorItemModel.init) }).bind(to: models).disposed(by: disposeBag)
        
        cellSelected.bind(onNext: cellSelectedAction(cellModel:)).disposed(by: disposeBag)
        correctAnswer.bind(onNext: correctAnswerAction).disposed(by: disposeBag)
        uncorrectAnswer.bind(onNext: uncorrectAnswerAction).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func cellSelectedAction(cellModel: ConstructorItemModel) {
        
        guard let currentWord = currentWord.value else { return }
        
        let answer = self.answer.value + String(cellModel.letter.value)
        
        let attemptType: AttemptType = self.currentAttempt == 0 ? .firstAttempt : .correctionAttempt(attempt: self.currentAttempt)
        
        let answerResult = testConfiguration.verifyAnswer(wordID: currentWord.id, answer: answer, attempt: attemptType)

        if answerResult == .correct {
            self.answer.accept(answer)
            cellModel.hideCell.onNext(())
            models.accept(models.value.filter({ $0 != cellModel }))
            
            if answer == currentWord.eng {
                self.correctAnswer.onNext(())
                self.currentAttempt = 0
                return
            }
        } else {
            cellModel.failSelect.onNext(())
            if self.currentAttempt >= testConfiguration.currentQuest.attemptCount {
                self.uncorrectAnswer.onNext(())
                self.currentAttempt = 0
                return
            }
        }
        self.currentAttempt += 1
    }
    
    private func correctAnswerAction() {
        if self.words.isEmpty {
            self.testConfiguration.nextQuest()
            return
        }
        self.currentWord.accept(self.words.removeFirst())
    }
    
    private func uncorrectAnswerAction() {
        if self.words.isEmpty {
            self.testConfiguration.nextQuest()
            return
        }
        self.currentWord.accept(self.words.removeFirst())
        
        
    }
    
}
