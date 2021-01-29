//
//  CollectionListItemModel.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxSwift

class CollectionListItemModel: ViewModel {
    
    let collection: Collection
        
    lazy var name = Observable.just(collection.name)
    lazy var count = Observable.just(collection.count)
    lazy var progressString = Observable.just("Изучено \(self.collection.completed) из \(self.collection.count)")
    
    
    init(_ collection: Collection){
        self.collection = collection
    }
    
    override func subscribe() {       
        
        
        
        super.subscribe()
    }
}
