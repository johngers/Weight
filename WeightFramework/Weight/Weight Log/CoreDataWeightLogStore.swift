//
//  CoreDataWeightLogStore.swift
//  Weight
//
//  Created by John Gers on 3/17/23.
//

import CoreData

public final class CoreDataWeightLogStore {
    private static let modelName = "WeightLogStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataWeightLogStore.self))

    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }
    
    public init(storeURL: URL) throws {
        guard let model = CoreDataWeightLogStore.model else {
            throw StoreError.modelNotFound
        }
        
        do {
            container = try NSPersistentContainer.load(name: CoreDataWeightLogStore.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
}
