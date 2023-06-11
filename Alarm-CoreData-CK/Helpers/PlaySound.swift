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
    private var player: AVAudioPlayer!
    private var isPlaying = false
    
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
                player.numberOfLoops = -1 // Play on repeat
                player.play()

                // Configure audio session for background playback
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
                try AVAudioSession.sharedInstance().setActive(true)

                self.isPlaying = true
                isPlaying.wrappedValue = true
            } catch {
                print("\(error)")
            }
        }
        
        func stopPlaying() {
            player.stop()
            player = nil
            isPlaying = false
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
