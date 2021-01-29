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
    let testConfiguration: TestConfiguration
    var currentAttempt = 0
    
    let getAllWords = GetAllWords.default.use().share()
    let getWords = GetWords.default
    
    let uncorrectAnswer = PublishSubject<Void>()
    let correctAnswer = PublishSubject<Void>()
    let cellSelected = PublishSubject<ChoiceItemModel>()
    
    let currentWord = BehaviorRelay<Word?>(value: nil)
    
    lazy var models = BehaviorRelay<[ChoiceItemModel]>(value: [])
    lazy var sections = models.map({ [SectionModel<String,ChoiceItemModel>(model: "", items: $0.shuffled())]})
    
    
    init(words: [Word], testConfiguration: TestConfiguration) {
        self.words = words
        self.testConfiguration = testConfiguration
    }
    
    override func subscribe() {
        
        self.currentWord.accept(words.removeFirst())
        self.cellSelected.bind(onNext: modelSelectedAction(cellModel:)).disposed(by: disposeBag)
        
        currentWord.unwrap().withLatestFrom(getAllWords, resultSelector: { word, allWords -> [ChoiceItemModel] in
            let synonyms = allWords.words.filter({word.synonymsID.contains($0.id) })
            var result: [Word] = []
            
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
        
        switch cellModel.word {
        case let word where word.id == currentWord.id || word.eng == currentWord.eng:
            testConfiguration.currentQuest.sendAnswer(wordID: currentWord.id, answerType: .correct)
            self.correctAnswer.onNext(())
        case let word where currentWord.synonymsID.contains(word.id):
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
