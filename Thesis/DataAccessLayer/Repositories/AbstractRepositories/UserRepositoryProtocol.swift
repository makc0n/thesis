//
//  UserRepositoryProtocol.swift
//  Thesis
//
//  Created by Максим Василаки on 29.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift


protocol UserRepositoryProtocol {
    
    func getUser() -> Observable<User>
    func newUser(user: User) -> Single<Void>
    func updateUser(updateUser: UpdateUser) -> Single<Void>
    func updateRequest(updateRequest: UpdateRequest) -> Single<Void>
    func refreshUserStates() -> Single<Void>
    
}
