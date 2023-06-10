//
//  AlarmContainer.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/3/23.
//

import CoreData
import CloudKit

class AlarmContainer {
    let persistentCloudKitContainer: NSPersistentCloudKitContainer
    
    init() {
        persistentCloudKitContainer = NSPersistentCloudKitContainer(name: "AlarmDataModel")
        guard let path = persistentCloudKitContainer
            .persistentStoreDescriptions
            .first?
            .url?
            .path else {
            fatalError("Could not find peresistent container")
        }
        print("Core Data", path)
        guard let description = persistentCloudKitContainer.persistentStoreDescriptions.first else {
            fatalError("Failed to initialize persistent container")
        }
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentCloudKitContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentCloudKitContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentCloudKitContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
