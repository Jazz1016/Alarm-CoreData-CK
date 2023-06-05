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
    
    init(with alarm: Alarm?) {
        
    }
}
