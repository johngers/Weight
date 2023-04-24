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
    internal static func items(from localLog: [LocalWeightItem], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localLog.map { local in
            let managed = ManagedWeightItem(context: context)
            managed.id = local.id
            managed.weight = local.weight
            managed.date = local.date
            return managed
        })
    }
    
    internal var local: LocalWeightItem {
        return LocalWeightItem(id: id, weight: weight, date: date)
    }
}
