//
//  SwipeGestureObserver.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation

protocol SwipeGestureObserverDelegate {
    func didSwipe()
}

class SwipeGestureObserver {
    static var newInstance = SwipeGestureObserver()
    
    var delegate: SwipeGestureObserverDelegate?
    var didSwipe: Bool = false {
        didSet {
            if (didSwipe) {
                delegate?.didSwipe()
            }
        }
    }
}
