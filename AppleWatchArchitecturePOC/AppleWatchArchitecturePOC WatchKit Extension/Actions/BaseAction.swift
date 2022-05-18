//
//  Action.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 16/05/22.
//

import Foundation
import SwiftUI

enum ActionKind {
    case TAP
    case DIGITAL_CROWN
    case SWIPE
}

protocol ActionDelegate {
    func onDetected(kind: ActionKind)
}

protocol Action {
    var kind: ActionKind { get }
    var delegate: ActionDelegate? {  get set }
    var text: String { get }
}
