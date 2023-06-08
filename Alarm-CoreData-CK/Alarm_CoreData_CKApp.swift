//
//  Alarm_CoreData_CKApp.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/3/23.
//

import SwiftUI
import BackgroundTasks

@main
struct Alarm_CoreData_CKApp: App {
    
    private var delegate: NotificationDelegate = NotificationDelegate()
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.delegate = delegate
        center.requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
            if let error = error {
                print(error)
            }
        }
        
        registerBackgroundFetch()
    }
    
    var body: some Scene {
        WindowGroup {
            AlarmListView()
                .environment(\.managedObjectContext, AlarmContainer().persistentContainer.viewContext)
        }
    }
    
    func registerBackgroundFetch() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.yourapp.backgroundfetch", using: nil) { task in
            self.handleBackgroundFetch(task: task as! BGAppRefreshTask)
        }
    }
    
    // Handle the background fetch task
    func handleBackgroundFetch(task: BGAppRefreshTask) {
        task.expirationHandler = {
            // Handle expiration if necessary
        }
        
        performBackgroundFetch { result in
            switch result {
            case .newData:
                task.setTaskCompleted(success: true)
            case .noData:
                task.setTaskCompleted(success: false)
            case .failed:
                task.setTaskCompleted(success: false)
            @unknown default:
                task.setTaskCompleted(success: false)
            }
        }
    }
    
    // Perform the background fetch
    func performBackgroundFetch(completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Perform your background tasks, such as syncing with a server or updating data
        
        // Call the completion handler with the appropriate result
        completionHandler(.newData) // Or .noData or .failed
    }
}
