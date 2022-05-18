//
//  SwipeAction.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation

class SwipeAction: Action, SwipeGestureObserverDelegate {
    var gestureObserver = SwipeGestureObserver.newInstance
    
    var kind: ActionKind = .SWIPE
    var delegate: ActionDelegate?
    var text: String = "Swipe"
    var detecting: Bool = false
    
    func startDetection() {
        self.detecting = true
        gestureObserver.delegate = self
    }
    
    func stopDetection() {
        self.detecting = false
    }
    
    func didSwipe() {
        if detecting {
            self.delegate?.onDetected(kind: self.kind)
        }
    }
    
}
