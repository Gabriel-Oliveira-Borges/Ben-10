//
//  TimerProvider.swift
//  benben WatchKit Extension
//
//  Created by Pedro Mota on 31/05/22.
//

import Foundation
import Combine

class TimerProvider {
    
    public var remainingTime: Int?
    
    private var subscription: Cancellable? = nil
    
    public weak var delegate: TimerProviderDelegate?
    public let totalTime: Int
    public var publisher = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .common)
    
    init(totalTime: Int) {
        self.totalTime = totalTime
        self.remainingTime = totalTime
    }
    
    func start() {
        subscription = publisher.connect()
    }
    
    func reset() {
        self.cancel()
        delegate?.timerDidReset()
    }
    
    func cancel() {
        subscription?.cancel()
        subscription = nil
        remainingTime = self.totalTime
        publisher = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .common)
    }
    
    func uptadeRemainingTime() {
        if remainingTime! == 0 {
            delegate?.timerDidEnd()
        } else {
            remainingTime = remainingTime! - 1
        }
    }
}

protocol TimerProviderDelegate: AnyObject {
    func timerDidEnd()
    func timerDidReset()
}
