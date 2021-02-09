//
//  CollectionRepositoryProtocol.swift
//  Thesis
//
//  Created by Максим Василаки on 13.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift

protocol CollectionRepositoryProtocol {
    
    func getCollection(collectionID: Int) -> Observable<Collection>
    func getCollections(collectionIDs: [Int]) -> Observable<[Collection]>
    func getCollections() -> Observable<[Collection]>
    
    func addCollection(collection: Collection) -> Single<Void>
    
    func addWords( wordIDs: [Int], toCollection collectionID: Int) -> Single<Void>
    func removeWords( wordIDs: [Int], fromCollection collectionID: Int) -> Single<Void>
    func refreshLearnProgress() -> Single<Void>
    func deleteCollection(collectionID: Int) -> Single<Void>
    
}
