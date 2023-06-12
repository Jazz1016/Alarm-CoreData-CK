//
//  PlaySound.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/6/23.
//

import AVFoundation
import SwiftUI

class PlaySound {
    static let shared = PlaySound()
    private var player: AVAudioPlayer?
    private var isPlaying = false
    private var bellPlayer: AVAudioPlayer?
    private var bellTimers: [Timer] = []
    
    func playSound(key: String) {
        guard let url = Bundle.main.url(forResource: key, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("\(error)")
        }
    }
    
    func playSoundOnLoop(key: String, isPlaying: Binding<Bool>) {
        guard let url = Bundle.main.url(forResource: key, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // Play on repeat
            player?.play()
            
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.isPlaying = true
            isPlaying.wrappedValue = true
        } catch {
            print("\(error)")
        }
    }
    
    func playBellNoises(intervals: [TimeInterval]) {
        guard let url = Bundle.main.url(forResource: "chime", withExtension: "mp3") else { return }
        
        do {
            bellPlayer = try AVAudioPlayer(contentsOf: url)
            bellPlayer?.prepareToPlay()
        } catch {
            print("\(error)")
        }
        
        // Stop any ongoing bell timers
        //        stopBellNoises()
        
        for interval in intervals {
            let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
                self?.playBellNoise()
            }
            bellTimers.append(timer)
        }
    }
    
    private func playBellNoise() {
        bellPlayer?.volume = 1.0
        bellPlayer?.play()
    }
    
    func stopPlaying() {
        player?.stop()
        player = nil
        isPlaying = false
    }
    
    func stopBellNoises() {
        bellPlayer?.stop()
        bellPlayer = nil
        
        for timer in bellTimers {
            timer.invalidate()
        }
        bellTimers.removeAll()
    }
    
    func togglePlaying(isPlaying: Binding<Bool>, key: String) {
        if self.isPlaying {
            stopPlaying()
            isPlaying.wrappedValue = false
        } else {
            playSoundOnLoop(key: key, isPlaying: isPlaying)
        }
    }
    
}
