//
//  TimerManager.swift
//  benben WatchKit Extension
//
//  Created by Lucas Vieira on 27/05/22.
//

import SwiftUI
import Foundation

class ActionTimer: Timer {
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}
