//
//  ManagedWeightItem.swift
//  Weight
//
//  Created on 3/17/23.
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
    
    internal static func find(in context: NSManagedObjectContext) throws -> ManagedWeightItem? {
        let request = NSFetchRequest<ManagedWeightItem>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    
    internal static func currentInstance(in context: NSManagedObjectContext) throws -> ManagedWeightItem {
        try find(in: context).map(context.delete)
        return ManagedWeightItem(context: context)
    }
    
    internal var local: LocalWeightItem {
        return LocalWeightItem(id: id, weight: weight, date: date)
    }
}
