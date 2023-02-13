//
//  RealmGroup.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/12/23.
//

import Foundation
import RealmSwift

final class RealmCoinGroup: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var coins = RealmSwift.List<RealmCoin>()
}
