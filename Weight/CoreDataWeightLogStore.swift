//
//  CoreDataWeightLogStore.swift
//  Weight
//
//  Created by John Gers on 3/17/23.
//

import CoreData

public final class CoreDataWeightLogStore: WeightLogStore {
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(modelName: "WeightLogStore", url: storeURL, in: bundle)
        context = container.newBackgroundContext()
    }
    
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
    
    private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
}
