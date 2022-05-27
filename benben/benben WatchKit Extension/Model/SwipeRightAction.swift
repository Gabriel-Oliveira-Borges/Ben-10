//
//  SwipeRightAction.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 26/05/22.
//

import Foundation

class SwipeRightAction: ActionModel, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
    
    var type: ActionType = .SWIPE_RIGHT
    var delegate: ActionDelegate?
    var text: String = "Swipe right"
    
    init() {
        viewObserver.addDelegate(self)
    }
    
    func didDetectViewInteraction(type: ActionType) {
        if(type == .SWIPE_RIGHT) {
            self.delegate?.onDetected(type: self.type)
        }
    }
}
