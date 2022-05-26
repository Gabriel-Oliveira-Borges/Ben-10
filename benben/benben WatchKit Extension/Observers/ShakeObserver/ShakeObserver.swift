//
//  ShakeObserver.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 24/05/22.
//

import Foundation
import CoreMotion

protocol ShakeObserverDelegate {
    func onWatchShake(didShakeWith sensibility: ShakeSensibility, direction: ShakeDirection)

    func shakeObserverError()
}


class ShakeObserver {
    var delegate: ShakeObserverDelegate?

    private let motionManager = CMMotionManager()
    private let sensibility: ShakeSensibility
    private let updateInterval: Double
    private var coodinates: ShakeCoordinates?
    private var lastShakeDate: Date

    init(sensibility: ShakeSensibility, updateInterval: Double = 0.05) {
        self.lastShakeDate = Date()
        self.updateInterval = updateInterval
        self.sensibility = sensibility
    }

    func start() {
        print("Shake Observer -> start()")
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer not available")
            delegate?.shakeObserverError()
            return
        }

        if (motionManager.isDeviceMotionAvailable) {
            motionManager.deviceMotionUpdateInterval = 1.0/60.0
            motionManager.showsDeviceMovementDisplay = true
            motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical)
        }

        motionManager.accelerometerUpdateInterval = updateInterval

        let motionQueue = OperationQueue()

        motionManager.startAccelerometerUpdates(to: motionQueue) { [self] accelerometerData, err in
            guard let data = accelerometerData else {
                print("No accelerometer data")
                print(err)
                self.delegate?.shakeObserverError()
                self.motionManager.stopAccelerometerUpdates()
                return
            }

            self.coodinates = ShakeCoordinates.accelerationToShakeCoordinates(data.acceleration)
            let maxValue = self.coodinates!.getMaxValue()

            if ((maxValue > self.sensibility.rawValue || fabs(self.coodinates!.z) > self.sensibility.rawValue) && self.isDateValid()) {
                self.lastShakeDate = Date()
                self.didShake()
            }

        }
    }
    
    func stop() {
        self.motionManager.stopAccelerometerUpdates()
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    private func isDateValid() -> Bool {
        let now = Date()
        let nextAllowedDate = self.lastShakeDate.addingTimeInterval(self.updateInterval)
        return now.compare(nextAllowedDate) == .orderedDescending
    }

    private func didShake() {
        self.delegate?.onWatchShake(
            didShakeWith: self.sensibility,
            direction: ShakeDirection.shakeCoordenatesToShakeDirection(coordenates: self.coodinates!)
        )
    }
}
