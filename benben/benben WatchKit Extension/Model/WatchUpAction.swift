//
//  ShakeAction.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 24/05/22.
//

import Foundation

class WatchUpAction: ShakeActionModel, ShakeObserverDelegate {
    var type: ActionType = .WATCH_UP
    var text: String = "Watch Up"
    
    var delegate: ActionDelegate?
    var shakeObserver = ShakeObserver(sensibility: .shakeSensibilityNormal)
    
    func onWatchShake(didShakeWith sensibility: ShakeSensibility, direction: ShakeDirection) {
        if (direction == .SHAKE_UP) {
            self.delegate?.onDetected(type: self.type)
        }
    }
    
    func shakeObserverError() {
        print("Erro ao observar shake")
    }
}
