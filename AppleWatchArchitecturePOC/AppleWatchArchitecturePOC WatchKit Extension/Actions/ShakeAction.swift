//
//  VoiceAction.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 19/05/22.
//

import Foundation
import AVFAudio

class ShakeAction: Action, ShakeObserverDelegate {
    var kind: ActionKind = .SHAKE_UP
    var delegate: ActionDelegate?
    var text: String = "Levante o braço"
    
    private var shakeObserver = ShakeObserver(sensibility: .shakeSensibilityNormal, updateInterval: 2)
    
    init() {
        shakeObserver.delegate = self
        shakeObserver.start()
    }
    
    func onWatchShake(didShakeWith sensibility: ShakeSensibility, direction: ShakeDirection) {
        print(direction)
    }
    
    func shakeObserverError() {
        //Todo: Remover as actions da viewmodel quando ocorrerem erros
    }
    
}

