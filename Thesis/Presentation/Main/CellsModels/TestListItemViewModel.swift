//
//  TestListItemViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 07.04.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift

class TestListItemViewModel: ViewModel {
    
    let testListItemType: TestListItemType
    
    lazy var title = Observable.just(testListItemType.title)
    
    init(testListItemType: TestListItemType) {
        self.testListItemType = testListItemType
    }
        
}
