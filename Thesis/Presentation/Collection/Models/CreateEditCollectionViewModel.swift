//
//  CreateEditCollectionViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxSwift
import RxDataSources

class CreateEditCollectionViewModel: ViewModel {
        
    private var collection: Collection
    
    init(editCollection collection: Collection){
        self.collection = collection
    }
    
    override init(){
        self.collection = Collection.defaultCollection()
    }
    
    lazy var name = BehaviorRelay<String?>(value: collection.name)
    lazy var usedIDs = BehaviorRelay<[String]>(value: collection.wordsIDs)
    
    let addWord = PublishSubject<Void>()
    let complete = PublishSubject<Void>()
    let modelDeleted = PublishSubject<WordItemModel>()
    
    lazy var wordItems = BehaviorRelay<[WordItemModel]>(value: [])
    lazy var wordSectionsItems = wordItems.map({[SectionModel<String,WordItemModel>(model: "", items: $0 )] })
    
    
    override func subscribe() {
        addWord.bind(onNext: addWordAction).disposed(by: disposeBag)
        complete.bind(onNext: completeAction).disposed(by: disposeBag)
        
        usedIDs.flatMap({ IDs in
            return GetWords.default.use(input: GetWords.Input(wordsIDs: IDs))
        }).map({$0.words.map(WordItemModel.init)}).bind(to: wordItems)
        .disposed(by: disposeBag)
        
        
        
        
        super.subscribe()
    }
    
    private func addWordAction(){
        Navigator.navigate(route: NavigationRoutes.selectWords(wordsIDs: usedIDs))
    }
    
    
    private func completeAction(){
        
        guard let name = name.value, !name.isEmpty else {
            AlertConstructor(title: "Ошибка!", message: "Название колекции пустое", style: .alert)
                .addAction(title: "OK", style: .cancel, actionKey: "").show()
            return
        }
        
        self.collection.name = name
        self.collection.wordsIDs = usedIDs.value
        
        AddCollection.default.use(input: AddCollection.Input(collection: collection)).subscribe().disposed(by: disposeBag)
              
        Navigator.navigate(route: NavigationRoutes.goBack)
    }
}
