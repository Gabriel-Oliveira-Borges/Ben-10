//
//  SwipeActionModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import SwiftUI

struct SwipeActionModel: ActionModel, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
    
    var type: ActionType = .SWIPE
    var delegate: ActionDelegate?
    var text: String = "String"
    var detecting: Bool = false
    
    init() {
        viewObserver.addDelegate(self)
    }
    
    func didDetectViewInteraction(type: ActionType) {
        if(type == .SWIPE) {
            self.delegate?.onDetected(type: self.type)
        }
    }
}
