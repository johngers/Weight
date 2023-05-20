//
//  CoreDataStore+WeightItemStore.swift
//  Weight
//
//  Created on 4/15/23.
//

import Foundation

extension CoreDataStore: WeightItemStore {
    public func retrieve(completion: @escaping RetrievalCompletion) {
        perform { context in
            completion(Result{
                try ManagedWeightItem.find(in: context).map {
                    return $0.local
                }
            })
        }
    }
    
    public func save(_ item: LocalWeightItem, completion: @escaping SaveCompletion) {
        perform { context in
            completion(Result{
                let managedItem = try ManagedWeightItem.currentInstance(in: context)
                managedItem.id = item.id
                managedItem.weight = item.weight
                managedItem.date = item.date

                try context.save()
            })
        }
    }
    
    public func deleteCachedItem(completion: @escaping DeletionCompletion) {
        perform { context in
            completion(Result{
                try ManagedWeightItem.find(in: context).map(context.delete).map(context.save)
            })
        }
    }
}
