//
//  LocalWeightItemLoader.swift
//  Weight
//
//  Created on 4/15/23.
//

import Foundation

public final class LocalWeightItemLoader {
    private let store: WeightItemStore

    public init(store: WeightItemStore) {
        self.store = store
    }
}

extension LocalWeightItemLoader {
    public typealias SaveResult = Result<Void, Error>

    public func save(_ log: [WeightItem], completion: @escaping (SaveResult) -> Void) {
        store.save(log.toLocal(), completion: completion)
    }
}

extension LocalWeightItemLoader: WeightItemLoader {
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let _ = self else { return }

            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(.some(cachedLog)):
                completion(.success(cachedLog.toModels()))
            case .success(.none):
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
