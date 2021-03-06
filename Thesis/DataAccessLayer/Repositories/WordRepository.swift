//
//  WordRepository.swift
//  Thesis
//
//  Created by Максим Василаки on 13.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanMapper
import RxSwiftExt

class WordRepository: WordRepositoryProtocol {
    
    private let realm = Realms.words.create()
    
//MARK: - Getting Actions
    func getWord(wordID: Int) -> Observable<Word> {
        return Observable.collection(from: self.realm.objects(RealmWord.self).filter("id == %@", wordID)).map(Mapper.map)
    }
    
    func getWords(wordsIDs: [Int]) -> Observable<[Word]> {
        return Observable.collection(from: self.realm.objects(RealmWord.self).filter("id IN %@", wordsIDs).sorted(byKeyPath: "eng")).map({ $0.map(Mapper.map) })
    }
    
    func getAllWords() -> Observable<[Word]> {
        return Observable.collection(from: self.realm.objects(RealmWord.self).sorted(byKeyPath: "eng")).map({ $0.map(Mapper.map) })
    }
    
    
//MARK: - Addition Actions
    
    func addWord(word: Word) -> Single<Int> {
        return Single.create(subscribe: { observer in
            let realmWord: RealmWord = Mapper.map(word)
            try! self.realm.write {
                self.realm.add(realmWord, update: .all)
            }
            observer(.success(realmWord.id))
            
            return Disposables.create()
        })
    }
    
    func addWords(words: [Word]) -> Single<[Int]> {
        return Single.create(subscribe: { observer in
            let realmWords: [RealmWord] = words.map(Mapper.map)
            try! self.realm.write {
                self.realm.add(realmWords, update: .all)
            }
            observer(.success(realmWords.map({$0.id})))
            
            return Disposables.create()
        })
    }
    
//MARK: - Change Actions
    func updateWord(rus: String?, eng: String?, transcription: String?, wordID: Int) -> Single<Void> {
        return Single.create(subscribe: { observer in
            if let realmWord = self.realm.object(ofType: RealmWord.self, forPrimaryKey: wordID) {
                try! self.realm.write {
                    realmWord.rus = rus != nil ? rus! : realmWord.rus
                    realmWord.eng = eng != nil ? eng! : realmWord.eng
                    realmWord.transcription = transcription != nil ? transcription! : realmWord.transcription
                }
                observer(.success(()))
            }
            return Disposables.create()
        })
    }
    
    func updateWordByQuest(wordID: Int, score: Double, priority: Double, answerResult: AnswerResult, testType: TestType, questType: QuestType, attemptType: AttemptType) -> Single<Void> {
        return Single.create(subscribe: { observer in
            if let realmWord = self.realm.object(ofType: RealmWord.self, forPrimaryKey: wordID) {
                
                let trainer = Trainer.instance
                var daysScore: Double = 0.0
                
                let updateRequest = UpdateRequest(testType: testType, questType: questType, attemptType: attemptType, answerResult: answerResult)
                let updateLastRequest = UpdateLastRequest(testType: testType, questType: questType, attemptType: attemptType, answerResult: answerResult)
                
                try! self.realm.write {
                    
                    if realmWord.lastRequest == nil {
                        
                        let lastRequest = RealmLastRequest()
                        lastRequest.update(lastRequestUpdate: updateLastRequest)
                        realmWord.lastRequest = lastRequest
                        
                    } else {
                        
                        daysScore = trainer.lastRequest[answerResult.rawValue] * (Double(Date().containedDays - (realmWord.lastRequest?.date.containedDays ?? 0)) * trainer.daysScoreMultiplication)
                        
                        realmWord.lastRequest?.update(lastRequestUpdate: updateLastRequest)
                    }
                    
                    realmWord.request?.update(updateRequest: updateRequest)
                    realmWord.score += score + daysScore
                    realmWord.priority += priority + daysScore
                    
                }
                
                observer(.success(()))
            }
            
            return Disposables.create()
        })
        
    }
    
    func addSynonyms(synonymsIDs: [Int], for wordID: Int) -> Single<Void> {
        return Single.create(subscribe: { observer in
            if let realmWord = self.realm.object(ofType: RealmWord.self, forPrimaryKey: wordID) {
                try! self.realm.write {
                    realmWord.appendSynonymIDs(synonymsIDs)
                }
            }
            
            var synonyms = synonymsIDs
            synonyms.append(wordID)
            
            for synonym in synonymsIDs {
                if let realmWord = self.realm.object(ofType: RealmWord.self, forPrimaryKey: synonym) {
                    try! self.realm.write {
                        realmWord.appendSynonymIDs(synonyms)
                    }
                }
            }
            observer(.success(()))
            return Disposables.create()
        })
    }
    
    func removeSynonym(synonymID: Int, wordID: Int) -> Single<Void> {
        return Single.create(subscribe: { observer in
            if let realmWord = self.realm.object(ofType: RealmWord.self, forPrimaryKey: wordID) {
                try! self.realm.write {
                    realmWord.deleteSynonym(synonymID)
                }
            }
            if let realmWord = self.realm.object(ofType: RealmWord.self, forPrimaryKey: synonymID) {
                try! self.realm.write {
                    realmWord.deleteSynonym(wordID)
                }
            }
            
            observer(.success(()))
            return Disposables.create()
        })
    }
    
//MARK: - removing
    func removeWord(wordID: Int) -> Single<Void> {
        return Single.create(subscribe: { observer in
            if let realmWord = self.realm.object(ofType: RealmWord.self, forPrimaryKey: wordID) {
                try! self.realm.write {
                    self.realm.delete(realmWord)
                }
                observer(.success(()))
            }
            return Disposables.create()
        })
    }
    
    
}
