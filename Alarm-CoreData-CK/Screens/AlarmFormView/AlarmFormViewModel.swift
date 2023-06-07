//
//  AlarmFormViewModel.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/4/23.
//

import SwiftUI
import CoreData

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
    
    
    
}
