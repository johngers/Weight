//
//  WeightStore.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public typealias CachedLog = [LocalWeightItem]

public protocol WeightLogStore {
    typealias DeleteResult = Result<Void, Error>
    typealias DeletionCompletion = (DeleteResult) -> Void
    
    typealias SaveResult = Result<Void, Error>
    typealias SaveCompletion = (SaveResult) -> Void

    typealias RetrievalResult = Result<CachedLog?, Error>
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
