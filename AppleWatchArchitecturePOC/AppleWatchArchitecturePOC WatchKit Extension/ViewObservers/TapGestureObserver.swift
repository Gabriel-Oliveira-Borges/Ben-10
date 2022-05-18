//
//  TapGestureObserver.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation

protocol TapGestureObserverDelegate {
    func didTap()
}

class TapGestureObserver {
    static var newInstance = TapGestureObserver()
    
    var delegate: TapGestureObserverDelegate?
    var didTap: Bool = false {
        didSet {
            if (didTap) {
                delegate?.didTap()
            }
        }
    }
}
