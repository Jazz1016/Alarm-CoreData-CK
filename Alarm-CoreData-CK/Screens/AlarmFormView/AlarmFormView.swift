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
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Alarm Title", text: $viewModel.title)
                    
                    DatePicker("Select Date", selection: $viewModel.date, displayedComponents: .date)
                    
                    TimePickerView(selectedHour: $viewModel.hour, selectedMinute: $viewModel.minute, isPM: $viewModel.isPM)
                }
                Section(header: Text("Select Sound")) {
                    ForEach(viewModel.soundsArr, id: \.self) { soundName in
                        SoundCell(soundString: soundName, isSelected: soundName == viewModel.sound)
                            .onTapGesture {
                                viewModel.sound = soundName
                            }
                    }
                }
            }
            .navigationTitle(viewModel.updating ? "Update Alarm" : "Create Alarm")
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
                        if viewModel.updating {
                            viewModel.editNotification()
                            updateAlarm()
                        } else {
                            createAlarm()
                        }
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
    func createAlarm() {
        guard viewModel.isValidForm else { return }
        viewModel.createNotification()
        let newAlarm = Alarm(context: moc)
        newAlarm.id = viewModel.id
        newAlarm.title = viewModel.title
        newAlarm.sound = viewModel.sound
        let alarmDate = viewModel.createDate(hour: viewModel.isPM ? viewModel.hour + 12 : viewModel.hour, minute: viewModel.minute, date: viewModel.date)
        let schedule = AlarmSchedule(context: moc)
        schedule.alarmTime = alarmDate
        schedule.selectedDates = NSArray(array: [alarmDate!])
        newAlarm.schedule = schedule
        try? moc.save()
        dismiss()
    }
    
    func updateAlarm() {
        guard viewModel.isValidForm else { return }
        if let selectedAlarm = alarms.first(where: {$0.id == viewModel.id}) {
            selectedAlarm.title = viewModel.title
            selectedAlarm.sound = viewModel.sound
            viewModel.editNotification()
            let alarmDate = viewModel.createDate(hour: viewModel.isPM ? viewModel.hour + 12 : viewModel.hour, minute: viewModel.minute, date: viewModel.date)
            let schedule = selectedAlarm.schedule
            schedule?.alarmTime = alarmDate
            try? moc.save()
            dismiss()
        }
    }
    
}

struct AlarmFormView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmFormView(viewModel: AlarmFormViewModel())
    }
}
