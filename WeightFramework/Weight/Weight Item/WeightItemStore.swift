//
//  WeightItemStore.swift
//  Weight
//
//  Created on 4/15/23.
//

import Foundation

public protocol WeightItemStore {
    typealias DeleteResult = Result<Void, Error>
    typealias DeletionCompletion = (DeleteResult) -> Void
    
    typealias SaveResult = Result<Void, Error>
    typealias SaveCompletion = (SaveResult) -> Void

    typealias RetrievalResult = Result<LocalWeightItem?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func deleteCachedItem(completion: @escaping DeletionCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func save(_ item: LocalWeightItem, completion: @escaping SaveCompletion)
    
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
