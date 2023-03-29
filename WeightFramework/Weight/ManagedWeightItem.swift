//
//  ManagedWeightItem.swift
//  Weight
//
//  Created by John Gers on 3/17/23.
//

import CoreData

@objc(ManagedWeightItem)
internal class ManagedWeightItem: NSManagedObject {
    @NSManaged internal var id: UUID
    @NSManaged internal var weight: Double
    @NSManaged internal var date: Date
    @NSManaged internal var cache: ManagedCache
}

extension ManagedWeightItem {
    internal static func items(from localLog: [LocalWeightItem], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localLog.map { local in
            let managed = ManagedWeightItem(context: context)
            managed.id = local.id
            managed.weight = local.weight
            managed.date = local.date
            return managed
        })
    }
    
    internal static func find(with id: UUID, in context: NSManagedObjectContext) throws -> ManagedWeightItem? {
        let request = NSFetchRequest<ManagedWeightItem>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedWeightItem.id), id])
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    
    internal static func insert(localItem: LocalWeightItem, in context: NSManagedObjectContext) -> ManagedWeightItem? {
        let managed = ManagedWeightItem(context: context)
        managed.id = localItem.id
        managed.weight = localItem.weight
        managed.date = localItem.date
        return managed
    }
    
    internal var local: LocalWeightItem {
        return LocalWeightItem(id: id, weight: weight, date: date)
    }
}
