//
//  ShakeDirection.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 24/05/22.
//

import Foundation

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
enum ShakeDirection: String {

    case SHAKE_UP = "up"
    case SHAKE_DOWN = "down"
    case SHAKE_LEFT = "left"
    case PUNCH = "right"
    case SHAKE_UNKNOWN = "unknown"

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
            return ShakeDirection.PUNCH
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
