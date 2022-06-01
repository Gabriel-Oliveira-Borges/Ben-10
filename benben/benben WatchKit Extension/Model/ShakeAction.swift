//
//  ShakeAction.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 26/05/22.
//

import Foundation

class ShakeAction: ShakeActionModel {
    var type: ActionType = .SHAKE
    var text: String = "Shake!"
    
    var delegate: ActionDelegate?
    var shakeObserver = ShakeObserver(sensibility: .shakeSensibilityNormal)
    
    func onWatchShake(didShakeWith sensibility: ShakeSensibility, direction: ShakeDirection) {
        self.delegate?.onDetected(type: self.type)
    }
    
    func shakeObserverError() {
        print("Erro ao observar shake")
    }
}
