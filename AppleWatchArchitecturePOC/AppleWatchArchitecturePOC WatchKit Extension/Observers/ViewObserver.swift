//
//  ViewObserver.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation

protocol ViewObserverDelegate {
    var viewObserver: ViewObserver { get set }

    func didDetectViewInteration(kind: ActionKind)
}

class ViewObserver {
    static var newInstance = ViewObserver()
    
    private var delegates: [ViewObserverDelegate] = []
    
    func addDelegate(_ delegate: ViewObserverDelegate) {
        self.delegates.append(delegate)
    }
    
    func onTapDetected() {
        notifyDelegates(kind: .TAP)
    }
    
    func onSwipeDetected() {
        notifyDelegates(kind: .SWIPE)
    }
    
    func onDigitalCrownDetected() {
        notifyDelegates(kind: .DIGITAL_CROWN)
    }
    
    private func notifyDelegates(kind: ActionKind) {
        delegates.forEach { delegate in
            delegate.didDetectViewInteration(kind: kind)
        }
    }
}
