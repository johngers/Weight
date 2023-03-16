//
//  WeightItem.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public struct WeightItem: Equatable {
    let id: UUID
    let weight: Double
    let date: Date
    
    public init(id: UUID, weight: Double, date: Date) {
        self.id = id
        self.weight = weight
        self.date = date
    }
}
