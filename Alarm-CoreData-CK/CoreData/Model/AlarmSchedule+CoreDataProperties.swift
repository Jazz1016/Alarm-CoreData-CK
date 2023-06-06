//
//  AlarmSchedule+CoreDataProperties.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/6/23.
//
//

import Foundation
import CoreData



extension AlarmSchedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmSchedule> {
        return NSFetchRequest<AlarmSchedule>(entityName: "AlarmSchedule")
    }

    @NSManaged public var alarmTime: Date?
    @NSManaged public var selectedDates: NSArray?
    @NSManaged public var reucurringDays: [Weekday]?

}

extension AlarmSchedule : Identifiable {

}
