//
//  Realm.swift
//  Thesis
//
//  Created by Максим Василаки on 15.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    static func invoke(onWrite: (Realm) -> Void) {
        let realm = try! Realm()
        try! realm.write {
            onWrite(realm)
        }
    }
    
    static func invoke(onWrite: () -> Void) {
        let realm = try! Realm()
        try! realm.write {
            onWrite()
        }
    }
    
    static var instance: Realm {
        return try! Realm()
    }
    

}
