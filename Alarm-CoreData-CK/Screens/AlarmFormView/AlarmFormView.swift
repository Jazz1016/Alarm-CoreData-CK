//
//  AlarmFormView.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/4/23.
//

import SwiftUI

struct AlarmFormView: View {
    @ObservedObject var viewModel: AlarmFormViewModel
    @FetchRequest(sortDescriptors: [])
    private var alarms: FetchedResults<Alarm>
    @Environment(\.managedObjectContext) var moc
    @State var title: String = ""
    @State var sound: String = "chime"
    @State var date = Date()
    @State var hour = 0
    @State var minute = 0
    @State var isPM = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Alarm Title", text: $title)
                    
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                    
                    //Need to pass bindings in
                    TimePickerView(selectedHour: $hour, selectedMinute: $minute, isPM: $isPM)
                    
                    Button() {
                        createAlarm()
                    } label: {
                        Text("Save Alarm")
                    }
                    .buttonStyle(.bordered)
                }
                Section("Select Sound") {
                    
                    HStack {
                        Spacer()
                        Text("chime")
                        Spacer()
                        Image(systemName: "play")
                            .foregroundColor(.blue)
                    }
                    
                    Text("correct_bell")
                    Text("doorbell")
                    Text("goat_bell")
                    Text("shop_door")
                }
            }
        }
    }
    
    func createAlarm() {
        let newAlarm = Alarm(context: moc)
        newAlarm.id = UUID().uuidString
        newAlarm.sound = sound
    }
    
}

struct AlarmFormView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmFormView(viewModel: AlarmFormViewModel(with: nil))
    }
}
