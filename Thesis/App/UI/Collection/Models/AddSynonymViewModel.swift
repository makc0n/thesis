//
//  AddSynonymViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxDataSources
import RxSwift

class AddSynonymViewModel: ViewModel {
    
    let synonymsIDs: BehaviorRelay<[String]>
    let wordID: String
    
    let getAllWords = GetAllWords.default.use().share()
    
    let allowSelection = BehaviorRelay<Bool>(value: true)
    let changeSelection = PublishSubject<Void>()
    let complete = PublishSubject<Void>()
        
    lazy var wordsItems = BehaviorRelay<[WordItemModel]>(value:[])
    lazy var wordsItemsSections = wordsItems.map({[SectionModel<String,WordItemModel>(model: "", items: $0 )] })
    
    init(wordID: String, synonymsIDs: BehaviorRelay<[String]>){
        self.wordID = wordID
        self.synonymsIDs = synonymsIDs
    }
    
    override func subscribe() {
        
        synonymsIDs.flatMap({ IDs in
            return GetAllWords.default.use().map({ $0.words.filter({!IDs.contains($0.id)}) })
        }).map({$0.map(WordItemModel.init)}).bind(to: wordsItems).disposed(by: disposeBag)
        
        
        changeSelection.bind(onNext: changeSelectionAction).disposed(by: disposeBag)
        complete.bind(onNext: completeAction).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    private func changeSelectionAction(){
        allowSelection.accept(!allowSelection.value)
        for item in wordsItems.value{
            item.isEdited.accept(allowSelection.value)
        }
    }
    
    private func completeAction(){
        let selectedIDs = wordsItems.value.filter({ $0 .isSelected.value }).map({$0.word.id})
        self.synonymsIDs.accept(selectedIDs)
        
        Navigator.navigate(route: NavigationRoutes.goBack)
    }
}
