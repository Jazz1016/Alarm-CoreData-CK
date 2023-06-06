//
//  Helpers.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/6/23.
//

import Foundation

class Helpers {
    
    static func getHourAndMinute(from date: Date) -> (hour: Int, minute: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return (hour, minute)
    }

}
