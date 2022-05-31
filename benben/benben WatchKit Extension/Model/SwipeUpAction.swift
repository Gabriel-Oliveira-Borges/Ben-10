//
//  SwipeActionModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import SwiftUI

class SwipeUpAction: ActionModel, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
    
    var type: ActionType = .SWIPE_UP
    var delegate: ActionDelegate?
    var text: String = "Swipe up"
    
    init() {
        viewObserver.addDelegate(self)
    }
    
    func didDetectViewInteraction(type: ActionType) {
        if(type == self.type) {
            self.delegate?.onDetected(type: self.type)
        }
    }
}
