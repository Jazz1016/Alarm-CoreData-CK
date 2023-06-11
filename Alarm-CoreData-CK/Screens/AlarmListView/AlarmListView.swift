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
    @Environment(\.managedObjectContext) var moc
    @State private var formType: FormType?
    @State var isShowingForm = false
    @State var isPlayingWhiteNoise = false
    
    
    var body: some View {
        NavigationStack {
            List {
                Toggle("White Noise", isOn: $isPlayingWhiteNoise)
                    .onChange(of: isPlayingWhiteNoise) { newValue in
                        toggleWhiteNoise(newValue)
                    }
                
                ForEach(alarms) { alarm in
                    Button {
                        formType = .update(alarm: alarm)
                    } label: {
                        Text("\(alarm.titleUnwrapped)")
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            deleteAlarm(alarm: alarm)
                        } label: {
                            Text("Delete")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("⏰ Alarms List")
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
        .sheet(item: $formType) { $0 }
    }
    
    func toggleWhiteNoise(_ isPlaying: Bool) {
            if isPlaying {
                // Start playing the white noise sound on repeat
                PlaySound.shared.playSoundOnLoop(key: "40_hz", isPlaying: $isPlayingWhiteNoise)
            } else {
                // Stop playing the white noise sound
                PlaySound.shared.stopPlaying()
            }
        }
    
    func deleteAlarm(alarm: Alarm) {
        if let selectedAlarm = alarms.first(where: {$0.id == alarm.id}) {
            NotificationHelper.deleteNotification(identifier: alarm.idUnwrapped)
            moc.delete(selectedAlarm)
            try? moc.save()
        }
    }
    
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView()
    }
}
