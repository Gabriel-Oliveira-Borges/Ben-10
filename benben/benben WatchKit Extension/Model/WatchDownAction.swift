//
//  ArmDown.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 24/05/22.
//

import Foundation

class WatchDownAction: ShakeActionModel, ShakeObserverDelegate {
    var type: ActionType = .WATCH_DOWN
    var text: String = "Watch Down!"
    
    var delegate: ActionDelegate?
    var shakeObserver = ShakeObserver(sensibility: .shakeSensibilityNormal)
    
    func onWatchShake(didShakeWith sensibility: ShakeSensibility, direction: ShakeDirection) {
        if (direction == .SHAKE_DOWN) {
            self.delegate?.onDetected(type: self.type)
        }
    }
    
    func shakeObserverError() {
        print("Erro ao observar shake")
    }
}
