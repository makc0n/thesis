//
//  SelectWordViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 31.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxSwift
import RxDataSources

class SelectWordViewModel: ViewModel {
    
    let usedWordsIDs: BehaviorRelay<[Int]>
       
    let getAllWords = GetAllWords.default.use().share()
    
    let add = PublishSubject<Void>()
    let complete = PublishSubject<Void>()
    let changeSelection = PublishSubject<Void>()
    let allowSelection = BehaviorRelay<Bool>(value: false)
    
    lazy var items = BehaviorRelay<[WordItemModel]>(value:[])
    lazy var sections = items.map({[SectionModel<String,WordItemModel>(model: "", items: $0 )] })
    
    
    
    
    init(_ usedWordsIDs: BehaviorRelay<[Int]>){
        self.usedWordsIDs = usedWordsIDs
    }
    
    override func subscribe() {
        
        getAllWords
            .map({ $0.words.filter({!self.usedWordsIDs.value.contains($0.id)}) })
            .map({ $0.map(WordItemModel.init) })
            .bind(to: items)
            .disposed(by: disposeBag)
        
        add.bind(onNext: addAction).disposed(by: disposeBag)
        complete.bind(onNext: completeAction).disposed(by: disposeBag)
        changeSelection.bind(onNext: changeSelectionAction).disposed(by: disposeBag)
        
        
        super.subscribe()
    }
    
    private func changeSelectionAction(){
        allowSelection.accept(!allowSelection.value)
        for item in self.items.value{
            item.isEdited.accept(allowSelection.value)
        }
    }
    
    private func addAction(){
        Navigator.navigate(route: NavigationRoutes.createWord)
    }
    
    private func completeAction(){
        let newWordsIDs = self.items.value.filter({$0.isSelected.value}).map({$0.word.id})
        var unionWords = usedWordsIDs.value
        unionWords.append(contentsOf: newWordsIDs)
        self.usedWordsIDs.accept(unionWords)
        
        Navigator.navigate(route: NavigationRoutes.goBack)
    }
}
