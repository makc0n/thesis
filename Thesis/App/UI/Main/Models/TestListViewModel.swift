//
//  TestListViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift

class TestListViewModel: ViewModel{
    
    
    let fastTestAction = PublishSubject<Void>()
    
    
    override func subscribe() {
        super.subscribe()
        
        
        fastTestAction.bind(onNext: fastTest).disposed(by: disposeBag)
        
    }
    
    private func fastTest(){
        Test.instance.setDefault()
        Navigator.navigate(route: NavigationRoutes.pushPreTest)
    }
}
