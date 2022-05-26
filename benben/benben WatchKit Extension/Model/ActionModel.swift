//
//  ActionModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation
import SwiftUI

enum ActionType {
    case TAP
    case DIGITAL_CROWN
    case SWIPE
    case PUNCH
    case WATCH_UP
    case WATCH_DOWN
    case SHAKE
}

protocol ActionDelegate {
    func onDetected(type: ActionType)
}

protocol ActionModel {
    var type: ActionType { get }
    var delegate: ActionDelegate? { get set }
    var text: String { get }
}


protocol ShakeActionModel: ActionModel, ShakeObserverDelegate {
    var shakeObserver: ShakeObserver { get set }
 
    func startDetection()
    
    func stopDetection()
}

extension ShakeActionModel {
    func startDetection() {
        print("\(self) has started detecting motion")
        shakeObserver.delegate = self
        shakeObserver.start()
    }
    
    func stopDetection() {
        print("\(self) has stopped detecting motion")
        shakeObserver.stop()
    }
}
