//
//  TapActionModel.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 24/05/22.
//

import Foundation


class TapAction: ActionModel, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
    var type: ActionType  = .TAP
    var delegate: ActionDelegate?
    var text: String = "Tap!"
    
    init() {
        viewObserver.addDelegate(self)
    }
    
    func didDetectViewInteraction(type: ActionType) {
        if (type == self.type) {
            delegate?.onDetected(type: self.type)
        }
    }
}
