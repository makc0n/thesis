//
//  CollectionViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 19.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxDataSources
import RxSwift

class CollectionViewModel: ViewModel {
    
    var collection: Collection
    
    let _getWords = GetWords.default
    let allowsMultipleSelection = BehaviorRelay<Bool>(value: false)
    
    let wordItemSelected = PublishSubject<WordItemModel>()
    let wordItemDeleted = PublishSubject<WordItemModel>()
    let addWord = PublishSubject<Void>()
    let longPress = PublishSubject<Void>()
    
    lazy var wordsIDs = BehaviorRelay<[String]>(value: self.collection.wordsIDs)
    
    lazy var wordItems = BehaviorRelay<[WordItemModel]>(value: [])
    lazy var wordSectionsItems = wordItems.map({ [SectionModel(model: "", items: $0)] })
    
    
    init(_ collection: Collection){
        self.collection = collection
    }

    override func subscribe() {
        
        _getWords.use(input: GetWords.Input(wordsIDs: collection.wordsIDs))
            .map({$0.words.map(WordItemModel.init)})
            .bind(to: wordItems)
            .disposed(by: disposeBag)
        
        wordItemSelected.bind { (itemModel) in
            Navigator.navigate(route: NavigationRoutes.editWord(word: itemModel.word))
        }.disposed(by: disposeBag)
        
        wordItemDeleted.map({$0.word.id}).bind(onNext: deleteWord(wordID:)).disposed(by: disposeBag)
        
        wordsIDs.flatMap({ IDs in
            return GetWords.default.use(input: GetWords.Input(wordsIDs: IDs))
        }).map({$0.words.map(WordItemModel.init)}).bind(to: wordItems)
        .disposed(by: disposeBag)
        
        wordsIDs.filter({!$0.isEmpty}).bind(onNext: addWordsToCollection(wordsIDs:)).disposed(by: disposeBag)
        
        longPress.bind(onNext: longPressAction).disposed(by: disposeBag)
        
        addWord.bind(onNext: {
            Navigator.navigate(route: NavigationRoutes.selectWords(wordsIDs: self.wordsIDs))
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func addWordsToCollection(wordsIDs: [String]) {
        if wordsIDs.count == collection.wordsIDs.count {return}
        collection.wordsIDs = collection.wordsIDs + wordsIDs
        AddWordsToCollection.default.use(input: AddWordsToCollection.Input(collectionID: self.collection.id, wordsIDs: wordsIDs)).subscribe().disposed(by: disposeBag)
    }
    
    private func deleteWord(wordID: String) {
        RemoveWordsFromCollection.default.use(input: .init(collectionID: self.collection.id, wordsIDs: [wordID])).subscribe().disposed(by: disposeBag)
        wordsIDs.accept(wordsIDs.value.filter({$0 != wordID}))
    }
    
    private func longPressAction(){
        allowsMultipleSelection.accept(!allowsMultipleSelection.value)
    }
}
