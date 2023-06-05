//
//  TimePicker.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/5/23.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var isPM: Bool
    
    var body: some View {
        VStack(spacing: -10) {
            HStack {
                Text("Selected Time: \(formattedTime)")
            }
            HStack {
                Picker("Hour", selection: $selectedHour) {
                    ForEach(0..<12, id: \.self) { hour in
                        Text("\(hour == 0 ? 12 : hour)")
                    }
                }
                .pickerStyle(.wheel)
                
                Picker("Minute", selection: $selectedMinute) {
                    ForEach(0..<60, id: \.self) { minute in
                        minute < 10 ? Text("0\(minute)") : Text("\(minute)")
                    }
                }
                .pickerStyle(.wheel)
                Toggle("PM", isOn: $isPM)
            }
        }
        .padding()
    }
    
    private var formattedTime: String {
        let hour = selectedHour == 0 ? 12 : selectedHour
        let period = isPM ? "PM" : "AM"
        return "\(hour):\(String(format: "%02d", selectedMinute)) \(period)"
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(selectedHour: .constant(0), selectedMinute: .constant(0), isPM: .constant(true))
    }
}
