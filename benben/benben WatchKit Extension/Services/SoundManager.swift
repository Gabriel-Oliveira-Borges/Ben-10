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
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error.\(error.localizedDescription)")
        }
    }
}
