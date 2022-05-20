//
//  ShakeObserver.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 19/05/22.
//

import Foundation
import CoreMotion

// ShakeDirection
//
// - shakeDirectionUp: y variation < 0 (Rotate your arm up to the Watch)
//
// - shakeDirectionDown: y variation > 0 (Rotate your arm down to the Watch)
//
// - shakeDirectionRight: x variation > 0 (Like a punch front to you)
//
// - shakeDirectionLeft: x variation < 0 (Like a pull a door to you)
//
// - shakeDirectionUnknow: When it's not possible to determine
enum ShakeDirection {
    
    case SHAKE_UP
    case SHAKE_DOWN
    case SHAKE_LEFT
    case SHAKE_RIGHT
    case SHAKE_UNKNOWN
    
    static func shakeCoordenatesToShakeDirection(_ x: Double, _ y: Double) -> ShakeDirection {
        return getShakeDirection(x, y)
    }
    
    static func shakeCoordenatesToShakeDirection(coordenates: ShakeCoordinates) -> ShakeDirection {
        return getShakeDirection(coordenates.x, coordenates.y)
    }
    
    static private func getShakeDirection(_ x: Double, _ y: Double) -> ShakeDirection {
        let valueX = fabs(x)
        let valueY = fabs(y)
     
        if valueX > valueY, x > 0 {
            return ShakeDirection.SHAKE_RIGHT
        }
        
        if valueX > valueY, x < 0 {
            return ShakeDirection.SHAKE_LEFT
        }
        
        if valueX < valueY, y > 0 {
            return ShakeDirection.SHAKE_DOWN
        }
        
        if valueX < valueY, y < 0 {
            return ShakeDirection.SHAKE_UP
        }
        
        return ShakeDirection.SHAKE_UNKNOWN
    }
}


enum ShakeSensibility: Double {
    public typealias RawValue = Double
    case shakeSensibilitySoftest = 0.1
    case shakeSensibilitySoft = 0.7
    case shakeSensibilityNormal = 1.0
    case shakeSensibilityHard = 1.2
    case shakeSensibilityHardest = 2.0
}

protocol ShakeObserverDelegate {
    func onWatchShake(didShakeWith sensibility: ShakeSensibility, direction: ShakeDirection)
    
    func shakeObserverError()
}

struct ShakeCoordinates {
    var x: Double
    var y: Double
    var z: Double
    
    static func accelerationToShakeCoordinates(_ acceleration: CMAcceleration) -> ShakeCoordinates {
        return ShakeCoordinates(x: acceleration.x, y: acceleration.y, z: acceleration.z)
    }
    
    func getMaxValue() -> Double {
        return fabs(x) > fabs(y) ? fabs(x) : fabs(y)
    }
}


class ShakeObserver {
    var delegate: ShakeObserverDelegate?
    
    private let motionManager = CMMotionManager()
    private let sensibility: ShakeSensibility
    private let updateInterval: Double
    private var coodinates: ShakeCoordinates?
    private var lastShakeDate: Date
    
    init(sensibility: ShakeSensibility, updateInterval: Double = 0.02) {
        self.lastShakeDate = Date()
        self.updateInterval = updateInterval
        self.sensibility = sensibility
    }
    
    func start() {
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
            guard let data = accelerometerData, let _ = err else {
                print("No accelerometer data")
                print(err)
                self.delegate?.shakeObserverError()
                self.motionManager.stopAccelerometerUpdates()
                return
            }
            
            self.coodinates = ShakeCoordinates.accelerationToShakeCoordinates(data.acceleration)
            let maxValue = self.coodinates!.getMaxValue()
            
            if (maxValue > self.sensibility.rawValue && self.isDateValid()) {
                self.lastShakeDate = Date()
                self.didShake()
            }
            
        }
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
