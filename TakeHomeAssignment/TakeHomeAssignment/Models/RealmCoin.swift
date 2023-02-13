//
//  RealmItem.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/12/23.
//

import Foundation
import RealmSwift

final class RealmCoin: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = "No coin"
    @Persisted var isFavorite: Bool = false
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    //@Persisted(originProperty: "coins") var group: LinkingObjects<RealmCoinGroup>
    
}
