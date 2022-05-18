//
//  DigitalCrownAction.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation

class DigitalCrownAction: Action, DigitalCrownObserverDelegate {
    var digitalCrownObserver = DigitalCrownObserver.newInstance
    
    var kind: ActionKind = .DIGITAL_CROWN
    var delegate: ActionDelegate?
    var text: String = "Gire!"
    var detecting: Bool = false
    
    func startDetection() {
        self.detecting = true
        digitalCrownObserver.delegate = self
    }
    
    func stopDetection() {
        self.detecting = false
    }
    
    func didRotateDigitalCrown() {
        if (self.detecting) {
            self.delegate?.onDetected(kind: self.kind)
        }
    }
}
