//
//  TapAction.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation


class TapAction: Action, TapGestureObserverDelegate {
    var gestureObserver = TapGestureObserver.newInstance
    
    var kind: ActionKind = .TAP
    var delegate: ActionDelegate?
    var text: String = "Tap"
    var detecting: Bool = false
    
    func startDetection() {
        self.detecting = true
        gestureObserver.delegate = self
    }
    
    func stopDetection() {
        self.detecting = false
    }
    
    func didTap() {
        if detecting {
            self.delegate?.onDetected(kind: self.kind)
        }
    }
}
