//
//  RealmWord.swift
//  Thesis
//
//  Created by Максим Василаки on 15.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWord: Object,RealmIdentifiableType {
    
    @objc dynamic var id = 0
    @objc dynamic var rus = ""
    @objc dynamic var eng = ""
    @objc dynamic var transcription = ""
    @objc dynamic var imageURL = ""
    @objc dynamic var score: Double = 0
    @objc dynamic var priority: Double = 0
    @objc dynamic var learnt: Bool = false
    @objc dynamic var request: RealmRequest? = RealmRequest()
    @objc dynamic var lastRequest: RealmLastRequest?
    
    var synonymsID = List<Int>()
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func appendSynonymIDs(_ ids:[Int]){
        var result = self.synonymsID.toArray()
        result.append(contentsOf: ids)
        result = Array(Set(result.filter({$0 != self.id})))
        synonymsID.removeAll()
        synonymsID.append(objectsIn: result)
    }
    
    func deleteSynonym(_ id: Int){
        var result = self.synonymsID.toArray()
        result.removeAll { (have) -> Bool in
            have == id
        }
        synonymsID.removeAll()
        synonymsID.append(objectsIn: result)
    }
}
