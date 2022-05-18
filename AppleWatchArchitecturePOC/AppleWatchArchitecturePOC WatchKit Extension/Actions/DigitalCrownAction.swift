//
//  DigitalCrownAction.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation

struct DigitalCrownAction: Action, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
    var kind: ActionKind = .DIGITAL_CROWN
    var delegate: ActionDelegate?
    var text: String = "Gire!"
    
    init() {
        viewObserver.addDelegate(self)
    }
    
    func didDetectViewInteration(kind: ActionKind) {
        if (kind == .DIGITAL_CROWN) {
            self.delegate?.onDetected(kind: self.kind)
        }
    }
}
