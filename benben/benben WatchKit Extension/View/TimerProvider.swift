//
//  TimerProvider.swift
//  benben WatchKit Extension
//
//  Created by Pedro Mota on 31/05/22.
//

import Foundation
import Combine

class TimerProvider: ObservableObject {
    
    @Published var remainingTime: Int?
    @Published var isRunning: Bool = false
    
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
        self.isRunning = true
    }
    
    func restart() {
        guard var remainingTime = remainingTime else { return }

        self.cancel()
        remainingTime = self.totalTime
        self.start()
    }
    
    func cancel() {
        guard let subscription = subscription else { return }
        
        subscription.cancel()
        isRunning = false
    }
    
    func uptadeRemainingTime() {
        if remainingTime! == 0 {
            self.cancel()
            delegate?.timerDidEnd()
        } else {
            remainingTime = remainingTime! - 1
        }
    }
}

protocol TimerProviderDelegate: AnyObject {
    
    func timerDidEnd()
    
}
