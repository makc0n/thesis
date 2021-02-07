//
//  CreateWordViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift
import RxCocoa
import RxSwiftExt
import RxDataSources

class CreateEditWordViewModel: ViewModel{
    
    private let collectionID: String
    private let word: Word
    let controllerType: ControllerType
    
    let saveWord = PublishSubject<Void>()
    let addSynonym = PublishSubject<Void>()
    let modelDeleted = PublishSubject<WordItemModel>()
    
    lazy var eng = BehaviorRelay<String?>(value: self.word.eng)
    lazy var rus = BehaviorRelay<String?>(value: self.word.rus)
    lazy var imageURL = BehaviorRelay<String?>(value: self.word.imageURL)
    lazy var transcription = BehaviorRelay<String?>(value: self.word.transcription)
    lazy var synonymsIDs = BehaviorRelay<[Int]>(value: self.word.synonymsID)
    
    lazy var synonymsItems = BehaviorRelay<[WordItemModel]>(value:[])
    lazy var synonymSectionsItems = synonymsItems.map({[SectionModel<String,WordItemModel>(model: "", items: $0 )] })
    
    
    override init(){
        self.controllerType = .create
        self.word = Word.defaultWord()
        self.collectionID = ""
    }
    
    init(editWord word: Word){
        self.controllerType = .edit
        self.word = word
        self.collectionID = ""
    }
    
    init(addWordToCollection collectionID: String){
        self.controllerType = .add
        self.collectionID = collectionID
        self.word = Word.defaultWord()
    }
    
    override func subscribe() {
        
        synonymsIDs.flatMap({ IDs in
            return GetWords.default.use(input: GetWords.Input(wordsIDs: IDs))
        }).map({$0.words.map(WordItemModel.init)}).bind(to: synonymsItems).disposed(by: disposeBag)
        
        saveWord.bind(onNext: saveWordAction).disposed(by: disposeBag)
        addSynonym.bind(onNext: addSynonymAction).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    
    private func saveWordAction(){
        
        guard let rus = self.rus.value, let eng = self.eng.value, let transcription = self.transcription.value else {
            return
        }
        
        if rus.isEmpty || eng.isEmpty {
            AlertConstructor(title: nil, message: "Обязательные поля не заполнены", style: .alert).addAction(title: "Ok", style: .cancel, actionKey: "").show()
            return
        }
        
        var newWord = self.word
        newWord.rus = rus
        newWord.eng = eng
        newWord.transcription = transcription
        
        AddWords.default.createUseCase(input: AddWords.Input(words: [newWord])).subscribe().disposed(by: disposeBag)
        AddSynonyms.default.createUseCase(input: AddSynonyms.Input(wordID: newWord.id, synonymsIDs: synonymsIDs.value)).subscribe().disposed(by: disposeBag)
        
        if !collectionID.isEmpty {
            AddWordsToCollection
                .default
                .use(input: AddWordsToCollection.Input(collectionID: collectionID, wordsIDs: [newWord.id]))
                .subscribe()
                .disposed(by: disposeBag)
        }
        
        Navigator.navigate(route: NavigationRoutes.goBack)
    }
    
    private func addSynonymAction(){
        Navigator.navigate(route: NavigationRoutes.addSynonyms(wordID: self.word.id, synonymsIDs: self.synonymsIDs))
    }
    
    
    enum ControllerType{
        case create,edit,add
    }
}
