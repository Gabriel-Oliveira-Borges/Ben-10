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
    case SWIPE_UP
    case SWIPE_DOWN
    case SWIPE_LEFT
    case SWIPE_RIGHT
    case LONG_PRESS
}

protocol ActionDelegate {
    func onDetected(type: ActionType)
}

protocol ActionModel {
    var type: ActionType { get }
    var delegate: ActionDelegate? { get set }
    var text: String { get }
}
