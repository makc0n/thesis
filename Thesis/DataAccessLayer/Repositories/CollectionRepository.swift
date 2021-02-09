//
//  CollectionRepository.swift
//  Thesis
//
//  Created by Максим Василаки on 15.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift
import CleanMapper
import RxSwiftExt

class CollectionRepository: CollectionRepositoryProtocol {
    
    private let realm = Realms.collections.create()
    
//MARK: -getting actions
    func getCollection(collectionID: Int) -> Observable<Collection> {
        return Observable.collection(from: self.realm.objects(RealmCollection.self).filter("id == %@", collectionID)).map(Mapper.map)
    }
    
    func getCollections(collectionIDs: [Int]) -> Observable<[Collection]> {
        return Observable.collection(from: self.realm.objects(RealmCollection.self).filter("id IN %@",collectionIDs).sorted(byKeyPath: "name")).map({ $0.map(Mapper.map) })
    }
    
    func getCollections() -> Observable<[Collection]> {
        return Observable.collection(from: self.realm.objects(RealmCollection.self).sorted(byKeyPath: "name")).map({$0.map(Mapper.map)})
    }
    
//MARK: -addition actions
    func addCollection(collection: Collection) -> Single<Void> {
        return Single.create(subscribe: { observer in
            let realmCollection: RealmCollection = Mapper.map(collection)
            
            try! self.realm.write {
                self.realm.add(realmCollection, update: .all)
            }
            
            observer(.success(()))
            return Disposables.create()
        })
    }
    
//MARK: -change actions
    func addWords(wordIDs: [Int], toCollection collectionID: Int) -> Single<Void> {
        return Single.create(subscribe: { observer in
            if let realmCollection = self.realm.object(ofType: RealmCollection.self, forPrimaryKey: collectionID) {
                var words = wordIDs
                words.append(contentsOf: realmCollection.wordIDs.toArray())
                words = Array( Set(words))
                try! self.realm.write {
                    realmCollection.wordIDs.removeAll()
                    realmCollection.wordIDs.append(objectsIn: words)
                }
                observer(.success(()))
            }
            return Disposables.create()
        })
    }
    
    func removeWords(wordIDs: [Int], fromCollection collectionID: Int) -> Single<Void> {
        return Single.create(subscribe: { observer in
            if let realmCollection = self.realm.object(ofType: RealmCollection.self, forPrimaryKey: collectionID) {
                let words = realmCollection.wordIDs.toArray().filter({!wordIDs.contains($0)})
                try! self.realm.write {
                    realmCollection.wordIDs.removeAll()
                    realmCollection.wordIDs.append(objectsIn: words)
                }
                observer(.success(()))
            }
            return Disposables.create()
        })
    }
    
    func refreshLearnProgress() -> Single<Void> {
        return Single.create(subscribe: { observer in
            let realmCollections = self.realm.objects(RealmCollection.self)
            let wordsRealm = Realms.words.create()
            
            for realmCollection in realmCollections {
                let countLearnt: Int = wordsRealm.objects(RealmWord.self).filter("id IN %@ AND learnt", realmCollection.wordIDs).count
                
                try! self.realm.write {
                    realmCollection.completed = countLearnt
                }
            }
            observer(.success(()))
            return Disposables.create()
        })
    }
   
    func deleteCollection(collectionID: Int) -> Single<Void> {
        return Single.create(subscribe: {observer in
            if let collection = self.realm.object(ofType: RealmCollection.self, forPrimaryKey: collectionID) {
                try! self.realm.write {
                    self.realm.delete(collection)
                }
            }
            observer(.success(()))
            return Disposables.create()
        })
    }
    
}
