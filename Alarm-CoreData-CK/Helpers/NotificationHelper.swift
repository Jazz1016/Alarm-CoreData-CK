//
//  NotificationHelper.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/7/23.
//

import Foundation
import UserNotifications

class NotificationHelper {
    
    static func createAlarm(date: Date, hour: Int, minute: Int) {
        let center = UNUserNotificationCenter.current()

        // Create content
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Time to wake up!"
        
        // Generate a unique identifier for this alarm
        let identifier = UUID().uuidString
        
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
    
}
