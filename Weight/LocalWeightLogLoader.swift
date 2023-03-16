//
//  LocalWeightLoader.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public final class LocalWeightLogLoader {
    private let store: WeightLogStore

    public typealias SaveResult = Error?
    public typealias LoadResult = LoadWeightResult

    public init(store: WeightLogStore) {
        self.store = store
    }
    
    public func save(_ log: [WeightItem], completion: @escaping (SaveResult) -> Void) {
        store.save(log.toLocal(), completion: completion)
    }
    
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { error in
            if let error = error {
                completion(.failure(error))
            }
        }
    }
}

private extension Array where Element == WeightItem {
    func toLocal() -> [LocalWeightItem] {
        return map {
            LocalWeightItem(id: $0.id, weight: $0.weight, date: $0.date)
        }
    }
}
