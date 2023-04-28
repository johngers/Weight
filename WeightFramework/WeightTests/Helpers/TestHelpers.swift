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

func uniqueWeightItem() -> WeightItem {
    return WeightItem(id: UUID(), weight: 100.0, date: Date())
}

func uniqueItem() -> (model: WeightItem, local: LocalWeightItem) {
    let item = WeightItem(id: UUID(), weight: 100.0, date: Date())
    let localItem = LocalWeightItem(id: item.id, weight: item.weight, date: item.date)
    return (item, localItem)
}
