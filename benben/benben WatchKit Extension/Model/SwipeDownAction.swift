//
//  SwipeDownAction.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 26/05/22.
//

import Foundation

class SwipeDownAction: ActionModel, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
    
    var type: ActionType = .SWIPE_DOWN
    var delegate: ActionDelegate?
    var text: String = "Swipe down!"
    
    init() {
        viewObserver.addDelegate(self)
    }
    
    func didDetectViewInteraction(type: ActionType) {
        if(type == self.type) {
            self.delegate?.onDetected(type: self.type)
        }
    }
}
