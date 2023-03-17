//
//  LocalWeightLoader.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public final class LocalWeightLogLoader {
    private let store: WeightLogStore

    public init(store: WeightLogStore) {
        self.store = store
    }
}

extension LocalWeightLogLoader {
    public typealias SaveResult = Error?

    public func save(_ log: [WeightItem], completion: @escaping (SaveResult) -> Void) {
        store.save(log.toLocal(), completion: completion)
    }
}

extension LocalWeightLogLoader: WeightLogLoader {
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let _ = self else { return }

            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .found(log):
                completion(.success(log.toModels()))
            case .empty:
                completion(.success([]))
            }
        }
    }
    
    public func delete(completion: @escaping (DeleteResult) -> Void) {
        store.deleteCachedLog { [weak self] result in
            guard let _ = self else { return }
            
            switch result {
            case .success:
                completion(.success(()))
            case let .failure(error):
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

private extension Array where Element == LocalWeightItem {
    func toModels() -> [WeightItem] {
        return map {
            WeightItem(id: $0.id, weight: $0.weight, date: $0.date)
        }
    }
}
