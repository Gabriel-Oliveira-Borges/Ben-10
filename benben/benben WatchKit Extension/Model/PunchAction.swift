//
//  ArmRight.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 24/05/22.
//

import Foundation

class PunchAction: ShakeActionModel, ShakeObserverDelegate {
    var type: ActionType = .PUNCH
    var text: String = "Punch"
    
    var delegate: ActionDelegate?
    var shakeObserver = ShakeObserver(sensibility: .shakeSensibilityNormal)
    
    func onWatchShake(didShakeWith sensibility: ShakeSensibility, direction: ShakeDirection) {
        if (direction == .PUNCH) {
            self.delegate?.onDetected(type: self.type)
        }
    }
    
    func shakeObserverError() {
        print("Erro ao observar shake")
    }
}
