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

public enum DeleteCachedLogResult {
    case success
    case failure(Error)
}

public protocol WeightLogStore {
    typealias DeletionCompletion = (DeleteCachedLogResult) -> Void
    typealias SaveCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveCachedLogResult) -> Void

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
