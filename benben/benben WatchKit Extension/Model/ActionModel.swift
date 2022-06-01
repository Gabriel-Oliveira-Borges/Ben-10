//
//  ActionModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation
import SwiftUI

enum ActionType: String {
    case TAP = "tap"
    case DIGITAL_CROWN = "spin_crown"
    case PUNCH = "punch"
    case WATCH_UP = "watch_up"
    case WATCH_DOWN = "watch_down"
    case SHAKE = "shake"
    case CELEBRATION = "celebration"
    case SWIPE_UP = "swipe_up"
    case SWIPE_DOWN = "swipe_down"
    case SWIPE_LEFT = "swipe_left"
    case SWIPE_RIGHT = "swipe_right"
    case LONG_PRESS = "press_hold"
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
        shakeObserver.delegate = self
        shakeObserver.start()
    }
    
    func stopDetection() {
        shakeObserver.delegate = nil
        shakeObserver.stop()
    }
}
