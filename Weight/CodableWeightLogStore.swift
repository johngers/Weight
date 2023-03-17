//
//  CodableWeightLogStore.swift
//  Weight
//
//  Created by John Gers on 3/17/23.
//

import Foundation

public class CodableWeightLogStore: WeightLogStore {
    private struct Cache: Codable {
        let log: [CodableWeightItem]
        
        var localLog: [LocalWeightItem] {
            return log.map { $0.local }
        }
    }
    
    private struct CodableWeightItem: Codable {
        private let id: UUID
        private let weight: Double
        private let date: Date
        
        init(_ item: LocalWeightItem) {
            id = item.id
            weight = item.weight
            date = item.date
        }
        
        var local: LocalWeightItem {
            return LocalWeightItem(id: id, weight: weight, date: date)
        }
    }
    
    private let storeURL: URL
    
    public init(storeURL: URL) {
        self.storeURL = storeURL
    }

    public func retrieve(completion: @escaping RetrievalCompletion) {
        guard let data = try? Data(contentsOf: storeURL) else {
            return completion(.empty)
        }
    
        do {
            let decoder = JSONDecoder()
            let cache = try decoder.decode(Cache.self, from: data)
            completion(.found(log: cache.localLog))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func save(_ log: [LocalWeightItem], completion: @escaping SaveCompletion) {
        var cachedLog: [LocalWeightItem] = []
        retrieve(completion: { result in
            switch result {
            case .found(log: let log):
                cachedLog = log
            default:
                break
            }
        })
        
        do {
            let log = log + cachedLog
            let encoder = JSONEncoder()
            let cache = Cache(log: log.map(CodableWeightItem.init))
            let encoded = try! encoder.encode(cache)
            try encoded.write(to: storeURL)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    public func deleteCachedLog(completion: @escaping DeletionCompletion) {
        guard FileManager.default.fileExists(atPath: storeURL.path) else {
            return completion(.success)
        }
        
        do {
            try FileManager.default.removeItem(at: storeURL)
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
}
