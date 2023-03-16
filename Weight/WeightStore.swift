//
//  WeightStore.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public enum RetrieveCachedLogResult {
    case empty
    case found(log: [LocalWeightItem])
    case failure(Error)
}

public protocol WeightLogStore {
    typealias SaveCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveCachedLogResult) -> Void

    func save(_ log: [LocalWeightItem], completion: @escaping SaveCompletion)
    func retrieve(completion: @escaping RetrievalCompletion)
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
