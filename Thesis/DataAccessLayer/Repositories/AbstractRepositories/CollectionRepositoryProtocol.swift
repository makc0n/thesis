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
    
    func getCollection(collectionID: String) -> Observable<Collection>
    func getCollections(collectionIDs: [String]) -> Observable<[Collection]>
    func getCollections() -> Observable<[Collection]>
    
    func addCollection(collection: Collection) -> Single<Void>
    
    func addWords( wordIDs: [String], toCollection collectionID: String) -> Single<Void>
    func removeWords( wordIDs: [String], fromCollection collectionID: String) -> Single<Void>
    func refreshLearnProgress() -> Single<Void>
    func deleteCollection(collectionID: String) -> Single<Void>
    
}
