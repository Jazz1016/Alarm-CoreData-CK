//
//  AlarmFormViewModel.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/4/23.
//

import SwiftUI
import CoreData
import UserNotifications

enum NotificationAction: String {
    case dismiss
    case reminder
}

enum NotificationCategory: String {
    case general
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    
}

class AlarmFormViewModel: ObservableObject {
    @FetchRequest(sortDescriptors: [])
    private var alarms: FetchedResults<Alarm>
    
    @Published var id: String       = UUID().uuidString
    @Published var title: String    = "Alarm"
    @Published var sound: String    = ""
    @Published var date             = Date()
    @Published var hour             = 0
    @Published var minute           = 0
    @Published var isPM             = false
    
    let soundsArr                   = ["chime", "correct_bell", "doorbell", "goat_bell", "shop_door"]
    
    var isValidForm: Bool {
        guard !title.isEmpty, !sound.isEmpty else { return false }
        return true
    }
    
    var updating: Bool = false
    
    init() {}
    
    init(with alarm: Alarm) {
        title = alarm.titleUnwrapped
        sound = alarm.audioLocation
        updating = true
        id = alarm.idUnwrapped
        //Need Date unwrapper for Date, hour, minute then based on hour get isPM bool
        if let alarmTime = alarm.schedule?.alarmTime {
            let (hr, min) = Helpers.getHourAndMinute(from: alarmTime)
            if hr > 12 {
                isPM = true
                self.hour = hr - 12
            } else {
                self.hour = hr
            }
            self.minute = min
            }
    }
    
    func createDate(hour: Int, minute: Int, date: Date) -> Date? {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        return calendar.date(from: dateComponents)
    }
    
    func createNotification() {
        let center = UNUserNotificationCenter.current()
        
        // Create content
        let content = UNMutableNotificationContent()
        let soundName = UNNotificationSoundName("\(sound).mp3")
        let sound = UNNotificationSound(named: soundName)
        content.title = "Hot Coffee"
        content.body = "Your delicious coffee is ready!"
        content.categoryIdentifier = NotificationCategory.general.rawValue
        content.sound = sound
        // Create trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        
        // Create request
        let request = UNNotificationRequest(identifier: "goy", content: content, trigger: trigger)
        
        let dismissAction = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: "Dismiss", options: [])
        
        let reminderAction = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
        
        let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dismissAction, reminderAction], intentIdentifiers: [], options: [])
        
        // Set notification categories
        center.setNotificationCategories([generalCategory])
        
        center.add(request) { error in
            if let error = error {
                print(error)
            }
        }
        
    }
    
    func editNotification() {
        
    }
    
}
