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
    
    func onTapDetected() {
        notifyDelegates(type: .TAP)
    }
    
    func onSwipeUpDetected() {
        notifyDelegates(type: .SWIPE_UP)
    }
    
    func onSwipeDownDetected() {
        notifyDelegates(type: .SWIPE_DOWN)
    }
    
    func onSwipeLeftDetected() {
        notifyDelegates(type: .SWIPE_LEFT)
    }
    
    func onSwipeRightDetected() {
        notifyDelegates(type: .SWIPE_RIGHT)
    }
    
    func onDigitalCrownDetected() {
        notifyDelegates(type: .DIGITAL_CROWN)
    }
    
    
    private func notifyDelegates(type: ActionType) {
        delegates.forEach { delegate in
            delegate.didDetectViewInteraction(type: type)
        }
    }
}
