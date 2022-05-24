//
//  SwipeAction.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation

class SwipeAction: Action, ViewObserverDelegate {
    var viewObserver: ViewObserver = .newInstance
    
    var kind: ActionKind = .SWIPE
    var delegate: ActionDelegate?
    var text: String = "Swipe"
    var detecting: Bool = false
    
    init() {
        viewObserver.addDelegate(self)
    }
    
    func didDetectViewInteration(kind: ActionKind) {
        if (kind == .SWIPE) {
            self.delegate?.onDetected(kind: self.kind)
        }
    }
}
