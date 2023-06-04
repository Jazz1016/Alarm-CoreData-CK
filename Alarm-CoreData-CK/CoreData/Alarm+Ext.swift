//
//  Alarm+Ext.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/3/23.
//

import Foundation

extension Alarm {
    var titleUnwrapped: String {
        title ?? ""
    }
    
    var audioID: String {
        id ?? ""
    }
}
