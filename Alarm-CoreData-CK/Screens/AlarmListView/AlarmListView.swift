//
//  AlarmListView.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/3/23.
//

import SwiftUI

struct AlarmListView: View {
    @FetchRequest(sortDescriptors: [])
    private var alarms: FetchedResults<Alarm>
    @State private var formType: FormType?
    @State var isShowingForm = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(alarms) { alarm in
                    Text("\(alarm.titleUnwrapped)")
                }
            }
        }
        .navigationTitle("Alarms List ⏰")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    formType = .new
                    
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
