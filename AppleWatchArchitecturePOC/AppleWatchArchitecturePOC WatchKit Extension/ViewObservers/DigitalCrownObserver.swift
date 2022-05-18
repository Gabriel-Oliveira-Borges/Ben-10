//
//  DigitalCrownObserver.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation


protocol DigitalCrownObserverDelegate {
    func didRotateDigitalCrown()
}

class DigitalCrownObserver {
    static var newInstance = DigitalCrownObserver()
    
    var delegate: DigitalCrownObserverDelegate?
    var didRotateDigitalCrown: Bool = false {
        didSet {
            if (didRotateDigitalCrown) {
                delegate?.didRotateDigitalCrown()
            }
        }
    }
}
