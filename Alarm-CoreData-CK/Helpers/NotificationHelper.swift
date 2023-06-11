//
//  NotificationHelper.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/7/23.
//

import Foundation
import UserNotifications

class NotificationHelper {
    
    static func createAlarm(identifier: String, date: Date, hour: Int, minute: Int) {
        let center = UNUserNotificationCenter.current()

        // Create content
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Time to wake up!"
        
        // Create trigger
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create request with the unique identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Schedule the notification request
        center.add(request) { error in
            if let error = error {
                print("Error scheduling alarm: \(error)")
            } else {
                print("Alarm scheduled successfully with identifier: \(identifier)")
            }
        }
    }
    
    static func deleteNotification(identifier: String) {
        let center = UNUserNotificationCenter.current()
        print(identifier)
        // Remove the notification request with the specified identifier
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    static func editNotification(identifier: String, alarm: Alarm) {
        
    }
    
}
