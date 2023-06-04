//
//  Alarm_CoreData_CKApp.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/3/23.
//

import SwiftUI

@main
struct Alarm_CoreData_CKApp: App {
    var body: some Scene {
        WindowGroup {
            AlarmListView()
                .environment(\.managedObjectContext, AlarmContainer().persistentContainer.viewContext)
        }
    }
}
