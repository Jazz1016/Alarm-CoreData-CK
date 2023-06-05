//
//  AlarmSchedule+CoreDataProperties.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/5/23.
//
//

import Foundation
import CoreData


extension AlarmSchedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmSchedule> {
        return NSFetchRequest<AlarmSchedule>(entityName: "AlarmSchedule")
    }

    @NSManaged public var recurringDays: NSObject?
    @NSManaged public var selectedDays: NSObject?
    @NSManaged public var alarmTime: Date?
    @NSManaged public var schedule: Alarm?

}

extension AlarmSchedule : Identifiable {

}
