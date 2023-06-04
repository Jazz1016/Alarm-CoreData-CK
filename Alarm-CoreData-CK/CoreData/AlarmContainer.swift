//
//  AlarmContainer.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/3/23.
//

import CoreData

class AlarmContainer {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "AlarmDataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
}
