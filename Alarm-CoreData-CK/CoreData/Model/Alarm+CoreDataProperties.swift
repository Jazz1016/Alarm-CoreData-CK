//
//  Alarm+CoreDataProperties.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/6/23.
//
//

import Foundation
import CoreData


extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var id: String?
    @NSManaged public var sound: String?
    @NSManaged public var title: String?
    @NSManaged public var schedule: AlarmSchedule?

}

extension Alarm : Identifiable {

}
