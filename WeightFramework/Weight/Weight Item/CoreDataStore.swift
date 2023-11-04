//
//  CoreDataStore.swift
//  Weight
//
//  Created on 4/15/23.
//

import SwiftData
import SwiftUI
import CoreData

public final class SwiftDataStore {
    private static let modelName = "Store"
    private let container: ModelContainer
    private let context: ModelContext
    
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }
    
    @MainActor
    public init(storeURL: URL, isStoredInMemoryOnly: Bool) throws {
        do {
            container = try ModelContainer(for: Schema([ManagedWeightItem.self]), configurations: .init(url: storeURL))
            newSwiftContext(
            context = ModelContext(container)
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
        func perform(_ action: @escaping (ModelContext) -> Void) {
            action(context)
        }
    
}

//public final class CoreDataStore {
//    private static let modelName = "Store"
//    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataStore.self))
//
//    private let container: NSPersistentContainer
//    private let context: NSManagedObjectContext
//    
//    
//    
//    public init(storeURL: URL) throws {
//        guard let model = CoreDataStore.model else {
//            throw StoreError.modelNotFound
//        }
//        
//        do {
//            container = try NSPersistentContainer.load(name: CoreDataStore.modelName, model: model, url: storeURL)
//            context = container.newBackgroundContext()
//        } catch {
//            throw StoreError.failedToLoadPersistentContainer(error)
//        }
//    }
//    
//    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
//        let context = self.context
//        context.perform { action(context) }
//    }
//}
