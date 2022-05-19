//
//  DigitalCrownActionModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation

struct DigitalCrownActionModel: ActionModel, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
    var type: ActionType = .DIGITAL_CROWN
    var delegate: ActionDelegate?
    var text: String = "Gire!"
    
    init() {
        viewObserver.addDelegate(self)
    }
    
    func didDetectViewInteraction(type: ActionType) {
        if(type == .DIGITAL_CROWN) {
            self.delegate?.onDetected(type: self.type)
        }
    }
}
