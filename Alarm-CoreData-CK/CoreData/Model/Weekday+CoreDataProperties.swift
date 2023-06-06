//
//  Weekday+CoreDataProperties.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/6/23.
//
//

import Foundation
import CoreData


extension Weekday {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weekday> {
        return NSFetchRequest<Weekday>(entityName: "Weekday")
    }

    @NSManaged public var day: Int32

}

extension Weekday : Identifiable {

}
