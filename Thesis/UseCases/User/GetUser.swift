//
//  GetUser.swift
//  Thesis
//
//  Created by Максим Василаки on 29.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanUseCase

class GetUser: ObservableUseCase<Void, GetUser.Output> {
    
    private var repository: UserRepositoryProtocol!
    
    convenience init(repository: UserRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: GetUser {
        return GetUser(repository: UserRepository())
    }
    
    override func createUseCase(input: Void) -> Observable<Output> {
        return repository.getUser().map(Output.init)
    }
    
}

extension GetUser {
    
    struct Output {
        let user: User
    }
    
}
