//
//  RealmIdentifiableType.swift
//  Thesis
//
//  Created by Максим Василаки on 23.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol RealmIdentifiableType where KeyType: Hashable {
    associatedtype KeyType
    var id: KeyType { get }
}
