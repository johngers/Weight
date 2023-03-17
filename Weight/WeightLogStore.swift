//
//  WeightStore.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public enum CachedFeed {
    case empty
    case found(log: [LocalWeightItem])
}

public protocol WeightLogStore {
    typealias DeleteResult = Result<Void, Error>
    typealias DeletionCompletion = (DeleteResult) -> Void
    typealias SaveCompletion = (Error?) -> Void
    typealias RetrievalResult = Result<CachedFeed, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func deleteCachedLog(completion: @escaping DeletionCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func save(_ log: [LocalWeightItem], completion: @escaping SaveCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion)
}

public struct LocalWeightItem: Equatable {
    public let id: UUID
    public let weight: Double
    public let date: Date
    
    public init(id: UUID, weight: Double, date: Date) {
        self.id = id
        self.weight = weight
        self.date = date
    }
}
