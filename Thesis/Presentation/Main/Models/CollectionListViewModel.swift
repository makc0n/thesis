//
//  WordsCollectionViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxDataSources
import RxSwift
import UIKit
import RealmSwift

class CollectionListViewModel: ViewModel{
    
    let addCollection = PublishSubject<Void>()
    
    private lazy var collectionListItems = BehaviorRelay<[CollectionListItemModel]>(value: [])
    lazy var collectionSectionsItems = collectionListItems.map({ models in
        return [SectionModel(model: "", items: models)]
    })
    
    
    let modelSelected = PublishSubject<CollectionListItemModel>()
    let modelDeleted = PublishSubject<CollectionListItemModel>()

    override func subscribe() {
        
        GetAllCollections.default.use().map({ $0.collections.map(CollectionListItemModel.init)}).bind(to: collectionListItems).disposed(by: disposeBag)
        
        addCollection.bind(onNext: addCollectionAction).disposed(by: disposeBag)
        
        modelDeleted.bind(onNext: { cellModel in
            DeleteCollection.default.use(input: .init(collectionID: cellModel.collection.id)).subscribe().disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        modelSelected.bind { (cellModel) in
            Navigator.navigate(route: NavigationRoutes.collection(collection: cellModel.collection))
        }.disposed(by: disposeBag)
        
        super.subscribe()
        
    }
    
    private func addCollectionAction(){
        Navigator.navigate(route: NavigationRoutes.createCollection)

    }
}
