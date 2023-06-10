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
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        if UIApplication.shared.applicationState == .background || UIApplication.shared.isProtectedDataAvailable == false {
//            // Check if the app is in the background or the device is locked
//
//        }
        
        completionHandler([.banner, .sound, .badge])
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
        content.title = "Alarm!"
        content.body = "ALARM NOTIFICATION ALERT!!!"
        content.categoryIdentifier = NotificationCategory.general.rawValue
        content.sound = sound

        // Create trigger
        let trigger = createNotificationTrigger(for: self.date, repeats: false)
        
        // Create request
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
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
    
    func createNotificationTrigger(for date: Date, repeats: Bool) -> UNNotificationTrigger? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.weekday, .hour, .minute], from: date)
        let weekday = dateComponents.weekday ?? 1  // Default to Sunday if weekday is not available

        var components = DateComponents()
        components.weekday = weekday
        components.hour = hour
        components.minute = minute

        // Calculate the time interval from the current date to the specified date and time
        guard let nextDate = calendar.nextDate(after: Date(), matching: components, matchingPolicy: .nextTime) else {
            return nil
        }

        let timeInterval = nextDate.timeIntervalSinceNow

        // Create the notification trigger with the calculated time interval
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
        print("timeInterval:", timeInterval, "nextDate", nextDate)
        return trigger
    }
    
    func editNotification() {
        NotificationHelper.deleteNotification(identifier: id)
        createNotification()
    }
    
}
