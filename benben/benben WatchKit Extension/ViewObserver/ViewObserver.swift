//
//  ViewObserver.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation

protocol ViewObserverDelegate {
    var viewObserver: ViewObserver { get set }
    
    func didDetectViewInteraction(type: ActionType)
}

class ViewObserver {
    static var newInstance = ViewObserver()
    
    private var delegates: [ViewObserverDelegate] = []
    
    func addDelegate(_ delegate: ViewObserverDelegate) {
        self.delegates.append(delegate)
    }
    
    private func notifyDelegates(type: ActionType) {
        delegates.forEach { delegate in
            delegate.didDetectViewInteraction(type: type)
        }
    }
    
    func onTapDetected() {
        notifyDelegates(type: .TAP)
    }
    
    func onSwipeDetected() {
        notifyDelegates(type: .SWIPE)
    }
    
    func onDigitalCrownDetected() {
        notifyDelegates(type: .DIGITAL_CROWN)
    }
}
