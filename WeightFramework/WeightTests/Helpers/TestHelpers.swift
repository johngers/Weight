//
//  TestHelpers.swift
//  WeightTests
//
//  Created on 3/16/23.
//

import Foundation
import Weight

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func uniqueItem() -> WeightItem {
    return WeightItem(id: UUID(), weight: 100.0, date: Date())
}

func uniqueWeightLog() -> (models: [WeightItem], local: [LocalWeightItem]) {
    let items = [uniqueItem()]
    let localItems = items.map { LocalWeightItem(id: $0.id, weight: $0.weight, date: $0.date) }
    return (items, localItems)
}
