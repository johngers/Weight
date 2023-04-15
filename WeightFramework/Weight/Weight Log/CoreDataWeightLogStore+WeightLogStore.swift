//
//  CoreDataWeightLogStore+WeightLogStore.swift
//  Weight
//
//  Created by John Gers on 3/28/23.
//

import Foundation

extension CoreDataWeightLogStore: WeightLogStore {
    public func retrieve(completion: @escaping RetrievalCompletion) {
        perform { context in
            completion(Result{
                try ManagedCache.find(in: context).map {
                    return CachedLog($0.localLog)
                }
            })
        }
    }
    
    public func save(_ log: [LocalWeightItem], completion: @escaping SaveCompletion) {
        perform { context in
            completion(Result{
                let managedCache = try ManagedCache.currentInstance(in: context)
                managedCache.log = ManagedWeightItem.items(from: log, in: context)
                
                try context.save()
            })
        }
    }
    
    public func deleteCachedLog(completion: @escaping DeletionCompletion) {
        perform { context in
            completion(Result{
                try ManagedCache.find(in: context).map(context.delete).map(context.save)
            })
        }
    }
}
