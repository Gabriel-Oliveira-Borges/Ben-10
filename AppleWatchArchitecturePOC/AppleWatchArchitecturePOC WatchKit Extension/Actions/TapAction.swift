//
//  TapAction.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation


struct TapAction: Action, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
        
    var kind: ActionKind = .TAP
    var delegate: ActionDelegate?
    var text: String = "Tap"

    init() {
        viewObserver.addDelegate(self)
    }


    func didDetectViewInteration(kind: ActionKind) {
        if (kind == .TAP) {
            self.delegate?.onDetected(kind: self.kind)
        }
    }
}
