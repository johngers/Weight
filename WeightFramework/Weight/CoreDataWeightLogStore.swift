//
//  CoreDataWeightLogStore.swift
//  Weight
//
//  Created by John Gers on 3/17/23.
//

import CoreData

public final class CoreDataWeightLogStore {
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(modelName: "WeightLogStore", url: storeURL, in: bundle)
        context = container.newBackgroundContext()
    }
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
}
