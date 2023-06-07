//
//  PlaySound.swift
//  Alarm-CoreData-CK
//
//  Created by James Lea on 6/6/23.
//

import AVFoundation

class PlaySound {
    static var shared = PlaySound()
    static var player: AVAudioPlayer!
    
    static func playSound(key: String) {
        guard let url = Bundle.main.url(forResource: key, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print("\(error)")
        }
        
    }
}
