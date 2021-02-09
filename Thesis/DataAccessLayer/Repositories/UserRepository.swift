//
//  UserRepository.swift
//  Thesis
//
//  Created by Максим Василаки on 29.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanMapper
import RxSwiftExt

class UserRepository: UserRepositoryProtocol {
    
    private let realm = Realms.user.create()
    
    func getUser() -> Observable<User> {
        return Observable.collection(from: self.realm.objects(RealmUser.self)).map({$0.first}).unwrap().map(Mapper.map)
    }
    
    func newUser(user: User) -> Single<Void> {
        return Single.create(subscribe: { observer in
            let realmUser: RealmUser = Mapper.map(user)
            try! self.realm.write {
                self.realm.deleteAll()
                self.realm.add(realmUser)
            }
            observer(.success(()))
            return Disposables.create()
        })
    }
    
    func updateUser(updateUser: UpdateUser) -> Single<Void> {
        return Single.create(subscribe: { observer in
            
            if let realmUser = self.realm.objects(RealmUser.self).first {
                
                try! self.realm.write {
                    if let newUserName = updateUser.userName {
                        realmUser.userName = newUserName
                    }
                    
                    if let lastVisitDate = updateUser.lastVisitDate {
                        realmUser.lastVisitDate = lastVisitDate
                    }
                    
                    if let stepForPriority = updateUser.stepForPriority {
                        realmUser.stepForPriority = stepForPriority
                    }
                }
                
                observer(.success(()))
            }
            
            return Disposables.create()
        })
    }
    
    func updateRequest(updateRequest: UpdateRequest) -> Single<Void> {
        return Single.create(subscribe: { observer in
            
            if let realmUser = self.realm.objects(RealmUser.self).first {
                
                try! self.realm.write {
                    realmUser.request?.update(updateRequest: updateRequest)
                }
                
                observer(.success(()))
            }
            
            return Disposables.create()
        })
    }
    
    
    func refreshUserStates() -> Single<Void> {
        return Single.create(subscribe: { observer in
            let words = Realms.words.create().objects(RealmWord.self).toArray()
            let collections = Realms.collections.create().objects(RealmCollection.self).toArray()
            
            if let realmUser = self.realm.objects(RealmUser.self).first {
                
                try! self.realm.write {
                    realmUser.countWords = words.count
                    realmUser.learntWords = words.map({$0.learnt.toInt()}).reduce(0, +)
                    realmUser.countCollection = collections.count
                    realmUser.learntCollection = collections.filter({$0.learnt}).count
                    realmUser.averagePriority = (words.map({$0.priority}).reduce(0, +)) / Double(words.count)
                    realmUser.totalScore = (words.map({$0.score}).reduce(0, +))
                    realmUser.averageScore =  realmUser.totalScore / Double(words.count)
                }
                observer( .success(()) )
            }
            
            return Disposables.create()
        })
    }
    
    
}
    
