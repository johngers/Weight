//
//  WeightStore.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public protocol WeightLogStore {
    typealias SaveCompletion = (Error?) -> Void
    func save(_ log: [LocalWeightItem], completion: @escaping SaveCompletion)
    func retrieve() 
}

public struct LocalWeightItem: Equatable {
    let id: UUID
    let weight: Double
    let date: Date
    
    public init(id: UUID, weight: Double, date: Date) {
        self.id = id
        self.weight = weight
        self.date = date
    }
}
