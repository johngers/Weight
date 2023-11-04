//
//  ManagedWeightItem.swift
//  Weight
//
//  Created by John Gers on 10/10/23.
//
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class ManagedWeightItem {
    var date: Date
    var id: UUID
    var weight: Double = 0.0
    
    init(date: Date, id: UUID, weight: Double) {
        self.date = date
        self.id = id
        self.weight = weight
    }
    
    internal var local: LocalWeightItem {
        return LocalWeightItem(id: id, weight: weight, date: date)
    }
}

final class ManagedWeightItemInstance {
    @Query(sort: \ManagedWeightItem.date)
    var find: [ManagedWeightItem]

    init() {
        
    }
}
