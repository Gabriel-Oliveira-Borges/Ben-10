//
//  ShakeCoordenates.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 24/05/22.
//

import Foundation
import CoreMotion

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
