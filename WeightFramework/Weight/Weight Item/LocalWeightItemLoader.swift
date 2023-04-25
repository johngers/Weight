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

    public func save(_ item: WeightItem, completion: @escaping (SaveResult) -> Void) {
        store.save(item.toLocal(), completion: completion)
    }
}

extension LocalWeightItemLoader: WeightItemLoader {
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let _ = self else { return }

            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(.some(cachedItem)):
                completion(.success(cachedItem.toModel()))
            case .success(.none):
                completion(.success(nil))
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

private extension WeightItem {
    func toLocal() -> LocalWeightItem {
        return LocalWeightItem(id: id, weight: weight, date: date)
    }
}

private extension LocalWeightItem {
    func toModel() -> WeightItem {
        return WeightItem(id: id, weight: weight, date: date)
    }
}
