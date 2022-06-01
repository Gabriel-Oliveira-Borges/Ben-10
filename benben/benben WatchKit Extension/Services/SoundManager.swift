//
//  SoundManager.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 24/05/22.
//

import SwiftUI
import AVFoundation


class SoundManager {
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case right = "right"
        case wrong = "wrong"
        case back = "back"
    }
    
    func playSound(sound: ActionType) {
        playSound(sound: sound.rawValue)
    }
    
    func playSound(sound: SoundOption) {
        playSound(sound: sound.rawValue)
    }
    
    func playSound(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if sound == "back" {
                player?.volume = 0.1
                player?.numberOfLoops = -1
            }
            player?.play()
        } catch let error {
            print("Error.\(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        do {
            player?.stop()
        } catch let error {
            print("Error.\(error.localizedDescription)")
        }
    }
}
