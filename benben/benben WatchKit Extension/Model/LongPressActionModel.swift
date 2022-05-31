//
//  LongPressActionModel.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 24/05/22.
//

import Foundation

class LongPressAction: ActionModel, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
    
    var type: ActionType = .LONG_PRESS
    
    var delegate: ActionDelegate?
    
    var text: String = "Press and hold"
    
    init() {
        viewObserver.addDelegate(self)
    }
    
    func didDetectViewInteraction(type: ActionType) {
        if (type == self.type) {
            delegate?.onDetected(type: self.type)
        }
    }
}

