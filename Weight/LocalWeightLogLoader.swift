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

    public init(store: WeightLogStore) {
        self.store = store
    }
    
    public func save(_ items: [WeightItem], completion: @escaping (SaveResult) -> Void) {
        store.save(items, completion: completion)
    }
}
