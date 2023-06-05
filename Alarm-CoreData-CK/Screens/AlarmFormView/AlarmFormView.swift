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
    @Environment(\.dismiss) var dismiss
    @State var title: String    = ""
    @State var sound: String    = ""
    @State var date             = Date()
    @State var hour             = 0
    @State var minute           = 0
    @State var isPM             = false
    let soundsArr               = ["chime", "correct_bell", "doorbell", "goat_bell", "shop_door"]
    
    var isValidForm: Bool {
        guard !title.isEmpty, !sound.isEmpty else { return false }
        return true
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Alarm Title", text: $title)
                    
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                    
                    //Need to pass bindings in
                    TimePickerView(selectedHour: $hour, selectedMinute: $minute, isPM: $isPM)
                }
                Section(header: Text("Select Sound")) {
                    ForEach(soundsArr, id: \.self) { soundName in
                        SoundCell(soundString: soundName, isSelected: soundName == sound)
                            .onTapGesture {
                                sound = soundName
                            }
                    }
                }
                Button() {
                    createAlarm()
                } label: {
                    Text("Save Alarm")
                }
                .buttonStyle(.bordered)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        createAlarm()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
    func createAlarm() {
        guard isValidForm else { return }
        let newAlarm = Alarm(context: moc)
        newAlarm.id = UUID().uuidString
        newAlarm.title = title
        newAlarm.sound = sound
        let alarmDate = createDate(hour: isPM ? hour + 12 : hour, minute: minute, date: date)
        newAlarm.schedule?.alarmTime = alarmDate
        newAlarm.schedule?.selectedDays = [alarmDate] as NSObject
        try? moc.save()
    }
    
    func createDate(hour: Int, minute: Int, date: Date) -> Date? {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        return calendar.date(from: dateComponents)
    }
    
}

struct AlarmFormView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmFormView(viewModel: AlarmFormViewModel(with: nil))
    }
}
