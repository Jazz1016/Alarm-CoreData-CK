//
//  AlarmListView.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/3/23.
//

import SwiftUI

struct AlarmListView: View {
    var body: some View {
        NavigationStack {
            List {
                
            }
        }
        .navigationTitle("Alarms List ⏰")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Add new Alarm
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView()
    }
}
